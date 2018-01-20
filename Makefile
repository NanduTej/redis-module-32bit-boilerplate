REDIS_VERSION=4.0.6

MODULE_SOURCE=src/mymodule.c
CFLAGS=-Iinclude -Wall -g -m32 -std=c99

###########################################################

BUILD_PATH=build
REDIS_MODULE=$(BUILD_PATH)/redis_module.so

# path to download redismodule.h corresponding to $(REDIS_VERSION)
define REDIS_MODULE_H_REMOTE
https://raw.githubusercontent.com/antirez/redis/$(REDIS_VERSION)/src/redismodule.h
endef

# Using dockcross (https://github.com/dockcross/dockcross)
# to provide a stable 32-bit gcc environment
DOCKCROSS=$(BUILD_PATH)/dockcross-linux-x86
CC=$(DOCKCROSS) gcc

## TARGETS
$(REDIS_MODULE): $(BUILD_PATH) $(MODULE_SOURCE) $(DOCKCROSS) include/redismodule.h
	$(CC) $(CFLAGS) -fPIC -shared $(MODULE_SOURCE) -o $(REDIS_MODULE)

$(DOCKCROSS): $(BUILD_PATH)
	# https://github.com/dockcross/dockcross
	docker run --rm dockcross/linux-x86 > $(DOCKCROSS)
	chmod +x $(DOCKCROSS)

include/redismodule.h:
	# note that this won't be removed by make clean
	wget -O"$@" $(REDIS_MODULE_H_REMOTE)

## OTHER TARGETS
$(BUILD_PATH):
	mkdir -p $(BUILD_PATH)

clean:
	rm -rf $(BUILD_PATH)

all: $(REDIS_MODULE)

.PHONY: all clean