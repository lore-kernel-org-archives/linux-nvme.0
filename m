From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 17 Jan 2018 12:37:35 +0200
Subject: [Suspected-Phishing]Re: [PATCH V3 1/2] nvme: split resetting
 state into reset_prepate and resetting
In-Reply-To: <2d198b6a-47f4-8d2b-024d-76161f4b0f90@oracle.com>
References: <1515647268-1717-1-git-send-email-jianchao.w.wang@oracle.com>
 <1515647268-1717-2-git-send-email-jianchao.w.wang@oracle.com>
 <b502ea5a-d319-3a03-0204-e2b6068bb55e@grimberg.me>
 <de132a4d-eb8b-10e8-7c96-7836edf1b52a@mellanox.com>
 <1c001532-234f-bc56-7fb4-bcd08142842e@mellanox.com>
 <2d198b6a-47f4-8d2b-024d-76161f4b0f90@oracle.com>
Message-ID: <538cb758-a343-a823-3a50-993a541414b3@grimberg.me>


> After Sagi's nvme-rdma: fix concurrent reset and reconnect, the rdma ctrl state is changed to RECONNECTING state
> after some clearing and shutdown work, then some initializing procedure,  no matter reset work path or error recovery path.
> The fc reset work also does the same thing.
> So if we define the range that RESET_PREPARE includes scheduling gap and disable and clear work, RESETTING includes initializing
> procedure,  RECONNECTING is very similar with RESETTING.
> 
> Maybe we could do like this;
> In nvme fc/rdma
> - set state to RESET_PREPARE, queue reset_work/err_work
> - clear/shutdown works, set state to RECONNECTING

Should be fine.

> In nvme pci
> - set state to RESET_PREPARE, queue reset_work
> - clear/shutdown works, set state to RESETTING
> - initialization, set state to LIVE

Given that we split reset state and we have a clear symmetry between
the transports, do we want to maybe come up with a unique state that is
coherent across all transports?

Maybe we rename them to NVME_CTRL_SHUTTING_DOWN and
NVME_CTRL_ESTABLISHING? I'm open for better names..
