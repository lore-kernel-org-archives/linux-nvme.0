From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 22 Jul 2019 20:57:51 -0700
Subject: [PATCH v2 10/10] nvme-cli: nvmf auto-connect scripts
In-Reply-To: <20190719225305.11397-11-jsmart2021@gmail.com>
References: <20190719225305.11397-1-jsmart2021@gmail.com>
 <20190719225305.11397-11-jsmart2021@gmail.com>
Message-ID: <4efefb70-7ab1-69af-4f41-63223e9f4ff8@grimberg.me>


> +# Events from persistent discovery controllers or nvme-fc transport events
> +ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_EVENT}=="discovery",\
> +  ENV{NVME_CTRL_NAME}=="*", ENV{NVME_TRTYPE}=="*", ENV{NVME_TRADDR}=="*", \
> +  ENV{NVME_TRSVCID}=="*", ENV{NVME_HOST_TRADDR}=="*", \
> +  RUN+="/usr/bin/systemctl --no-block start nvmf-connect at --device=$env{NVME_CTRL_NAME}\t--transport=$env{NVME_TRTYPE}\t--traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service"

James, shouldn't this be /bin/systemctl?
