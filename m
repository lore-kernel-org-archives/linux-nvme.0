From: hare@suse.de (Hannes Reinecke)
Date: Fri, 5 Oct 2018 07:50:05 +0200
Subject: [PATCH rfc 0/3] add support to discovery async event notifications
In-Reply-To: <20181004212328.30205-1-sagi@grimberg.me>
References: <20181004212328.30205-1-sagi@grimberg.me>
Message-ID: <cbf24fc6-a6dd-dcc4-35ce-97bec248dd32@suse.de>

On 10/4/18 11:23 PM, Sagi Grimberg wrote:
> In order to support discovery AENs we need to have two things:
> 1. Support long lived discovery controller sessions that would allow to
>     receive discovery AENs. This means we need to specify kato in connect
> 
> 2. Support discovery log change events. The choice here is to simply fire
>     a udev event and let userspace to:
>     1. issue an updated discovery log page via our discovery controller (1)
>     2. connect to every new subsystem/port that exists in the system.
> 
> This patch set was developed against the nvmet support patch set from Jay.
> 
> nvme-cli patches are also included in this series.
> 
> the udev rule that ultimately achieves dynamic discovery enumeration (TP 8002)
> is:
> 
> SUBSYSTEM=="nvme", ACTION=="change", \
>    RUN+="/usr/sbin/nvme connect-all --device=nvme$env{NVME_INSTANCE} --transport=$env{NVME_TRTYPE} \
>    --traddr=$env{NVME_TRADDR} --trsvcid=$env{NVME_TRSVCID} & disown
> 
Not sure that'll work; IIRC udev doesn't follow the bash syntax of '&' 
here. Have you checked?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
