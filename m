From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 12 Jul 2019 10:55:11 -0700
Subject: [PATCH rfc v2 10/10] nvme-cli: nvmf auto-connect scripts
In-Reply-To: <20190712003140.16221-11-jsmart2021@gmail.com>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-11-jsmart2021@gmail.com>
Message-ID: <6627bc48-cdda-dace-b7a9-6e6eb5530d72@grimberg.me>


> diff --git a/nvmf-autoconnect/70-nvmf-autoconnect.rules b/nvmf-autoconnect/70-nvmf-autoconnect.rules
> new file mode 100644
> index 0000000..b241b12
> --- /dev/null
> +++ b/nvmf-autoconnect/70-nvmf-autoconnect.rules
> @@ -0,0 +1,18 @@
> +#
> +# nvmf-autoconnect.rules:
> +#   Handles udev events which invoke automatically scan via discovery
> +#   controller and connect to elements in the discovery log.
> +#
> +#
> +
> +# Events from persistent discovery controllers or nvme-fc transport events
> +ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_EVENT}=="discovery",\
> +  ENV{NVME_CTLR_NAME}=="*", ENV{NVME_TRTYPE}=="*", ENV{NVME_TRADDR}=="*", \
> +  ENV{NVME_TRSVCID}=="*", ENV{NVME_HOST_TRADDR}=="*", \
> +  RUN+="/usr/bin/systemctl --no-block start nvmf-connect at --quiet\t--device=$env{NVME_CTLR_NAME}\t--transport=$env{NVME_TRTYPE}\t--traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service"

NVME_CTRL_NAME
