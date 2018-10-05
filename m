From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 5 Oct 2018 00:08:03 -0700
Subject: [PATCH rfc 0/3] add support to discovery async event notifications
In-Reply-To: <cbf24fc6-a6dd-dcc4-35ce-97bec248dd32@suse.de>
References: <20181004212328.30205-1-sagi@grimberg.me>
 <cbf24fc6-a6dd-dcc4-35ce-97bec248dd32@suse.de>
Message-ID: <6874c24e-28ec-97da-5d31-6a9215f995e1@grimberg.me>


>> the udev rule that ultimately achieves dynamic discovery enumeration 
>> (TP 8002)
>> is:
>>
>> SUBSYSTEM=="nvme", ACTION=="change", \
>> ?? RUN+="/usr/sbin/nvme connect-all --device=nvme$env{NVME_INSTANCE} 
>> --transport=$env{NVME_TRTYPE} \
>> ?? --traddr=$env{NVME_TRADDR} --trsvcid=$env{NVME_TRSVCID} & disown
>>
> Not sure that'll work; IIRC udev doesn't follow the bash syntax of '&' 
> here. Have you checked?

This works.
