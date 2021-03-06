ARCH_LIBS :=
ARCH_CFLAGS :=
MICRONDK_TARGET_CFLAGS := $(ARCH_CFLAGS) $(LOCAL_CFLAGS) $(CFLAGS)

PROJECT_OUTPUT ?= generated-project

ifneq ($(64BIT),1)
64BIT := 0
endif

ifneq ($(BUILD_GENERATED),)
ifeq ($(MODNAME),)
BINARY_OUTPUT ?= $(LOCAL_MODULE)
else
BINARY_OUTPUT ?= $(LOCAL_MODULE)_$(MODNAME)
endif
$(BINARY_OUTPUT): $(PROJECT_OUTPUT)
	_64BIT="$(64BIT)" sh $(MICRONDK_DIR)/gen/$(GENERATE)/build.sh $(BUILD_GENERATED) $(PROJECT_OUTPUT) $(BINARY_OUTPUT)
endif

$(PROJECT_OUTPUT):
	INCLUDES="$(LOCAL_C_INCLUDES)" SOURCES="$(LOCAL_SRC_FILES)" CFLAGS="$(MICRONDK_TARGET_CFLAGS)" CPPFLAGS="$(LOCAL_CPPFLAGS)" sh $(MICRONDK_DIR)/gen/$(GENERATE)/gen.sh $(PROJECT_OUTPUT)

