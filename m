From: james.smart@broadcom.com (James Smart)
Date: Tue, 7 May 2019 13:26:43 -0700
Subject: [PATCH nvme-cli rfc 5/5] nvmf auto-connect scripts
In-Reply-To: <20190504000456.3888-6-jsmart2021@gmail.com>
References: <20190504000456.3888-1-jsmart2021@gmail.com>
 <20190504000456.3888-6-jsmart2021@gmail.com>
Message-ID: <fd4af817-3a90-380b-b485-81b44c12c8e9@broadcom.com>


> +# Events from persistent discovery controllers or nvme-fc transport events
> +ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_EVENT}=="discovery",\
> +  ENV{NVME_CTLR_NAME}=="*", ENV{NVME_TRTYPE}=="*", ENV{NVME_TRADDR}=="*", \
> +  ENV{NVME_TRSVCID}=="*", ENV{NVME_HOST_TRADDR}=="*", \
> +  RUN+="/usr/bin/systemctl --no-block start nvmf-connect at --device=$env{NVME_CTLR_NAME}\t--transport=$env{NVME_TRTYPE}\t--traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service"
> +
> +# nvme-fc transport generated events (old-style for compatibility)
> +ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
> +  ENV{NVMEFC_HOST_TRADDR}=="*",  ENV{NVMEFC_TRADDR}=="*", \
> +  RUN+="/usr/bin/systemctl --no-block start nvmf-connect at --device=none\t--transport=fc\t--traddr=$env{NVMEFC_TRADDR}\t--trsvcid=none\t--host-traddr=$env{NVMEFC_HOST_TRADDR}.service"
>

I assume, that we should be adding --quiet to the above lines.? No need 
to get it from the event.? Agree ?

And we would not add --persistent.?? Which makes me assume --persistent 
would be left to manual/scripted calls or possibly pulled in by the 
"defaults" file we were discussing.??? So, the linux policy is our 
default discovery controller is non-persistent and requires admin 
actions to enable the persistent option - as opposed to - looking at 
IdentifyController:KAS to decide if KATO is supported, and if so, make 
the connection persistent ?

-- james
