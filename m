From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 5 Dec 2017 00:27:34 +0900
Subject: [PATCH 2/2] nvme-cli: support to set the property for NVMe over
 Fabric
In-Reply-To: <1512396404-18872-3-git-send-email-guanjunxiong@huawei.com>
References: <1512396404-18872-1-git-send-email-guanjunxiong@huawei.com>
 <1512396404-18872-3-git-send-email-guanjunxiong@huawei.com>
Message-ID: <CAA7jzteRTxRxUO9g0ra0DMZy1TYnhz9c8poYw+XbC6+3GrUVtw@mail.gmail.com>

Hello Guan,

> +int nvme_set_property(int fd, int offset, int value)
> +{
> +       __le64 val = cpu_to_le64(value);
> +       __le32 off = cpu_to_le32(offset);
> +       bool is64bit = false;
                               ^^^^^^^
Local variable __is64bit__ will be set a bit later in a switch statement.
Initialization seems unnecessary for this local variable.

> +static int set_property(int argc, char **argv, struct command *cmd, struct plugin *plugin)
> +{
> +       const char *desc = "Writes and shows the defined NVMe controller property "\
> +                          "for NVMe ove Fabric";
> +       const char *offset = "the offset of the property";
> +       const char *value = "the value of the property to be set";
> +       int fd, err;
> +
> +       struct config {
> +               int offset;
> +               int value;
> +       };
> +
> +       struct config cfg = {
> +               .offset = -1,
> +               .value = -1,
> +       };
> +
> +       const struct argconfig_commandline_options command_line_options[] = {
> +               {"offset", 'o', "NUM", CFG_POSITIVE, &cfg.offset, required_argument, offset},
> +               {"value", 'v', "NUM", CFG_POSITIVE, &cfg.value, required_argument, value},
> +               {NULL}
> +       };
> +
> +       fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
> +       if (fd < 0)
> +               return fd;
> +
> +       if (cfg.offset == -1) {
> +               fprintf(stderr, "offset required param");
> +               return EINVAL;
> +       }
> +       if (cfg.value == -1) {
> +               fprintf(stderr, "value required param");
> +               return EINVAL;
> +       }
> +
> +       err = nvme_set_property(fd, cfg.offset, cfg.value);
> +       if (err < 0) {
> +               perror("set-property");
> +               return errno;
                               ^^^^^
__errno__ can be found nowhere in this scope. __err__?

Thanks,
