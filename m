From: james.smart@broadcom.com (James Smart)
Date: Tue, 23 Jul 2019 09:04:34 -0700
Subject: [PATCH v2 10/10] nvme-cli: nvmf auto-connect scripts
In-Reply-To: <4efefb70-7ab1-69af-4f41-63223e9f4ff8@grimberg.me>
References: <20190719225305.11397-1-jsmart2021@gmail.com>
 <20190719225305.11397-11-jsmart2021@gmail.com>
 <4efefb70-7ab1-69af-4f41-63223e9f4ff8@grimberg.me>
Message-ID: <d5b4ef61-cf1d-ce9c-1bd0-7f372f874320@broadcom.com>



On 7/22/2019 8:57 PM, Sagi Grimberg wrote:
>
>> +# Events from persistent discovery controllers or nvme-fc transport 
>> events
>> +ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_EVENT}=="discovery",\
>> +? ENV{NVME_CTRL_NAME}=="*", ENV{NVME_TRTYPE}=="*", 
>> ENV{NVME_TRADDR}=="*", \
>> +? ENV{NVME_TRSVCID}=="*", ENV{NVME_HOST_TRADDR}=="*", \
>> +? RUN+="/usr/bin/systemctl --no-block start 
>> nvmf-connect at --device=$env{NVME_CTRL_NAME}\t--transport=$env{NVME_TRTYPE}\t--traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service"
>
> James, shouldn't this be /bin/systemctl?

I don't believe so.?? On the distros I checked, /bin/systemctl is a soft 
or hard link to /usr/bin/systemctl

-- james
