From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 16 Jan 2018 13:57:51 +0800
Subject: [Suspected-Phishing]Re: [PATCH V3 1/2] nvme: split resetting
 state into reset_prepate and resetting
In-Reply-To: <1c001532-234f-bc56-7fb4-bcd08142842e@mellanox.com>
References: <1515647268-1717-1-git-send-email-jianchao.w.wang@oracle.com>
 <1515647268-1717-2-git-send-email-jianchao.w.wang@oracle.com>
 <b502ea5a-d319-3a03-0204-e2b6068bb55e@grimberg.me>
 <de132a4d-eb8b-10e8-7c96-7836edf1b52a@mellanox.com>
 <1c001532-234f-bc56-7fb4-bcd08142842e@mellanox.com>
Message-ID: <2d198b6a-47f4-8d2b-024d-76161f4b0f90@oracle.com>

Hi Max

Thanks for your kindly comment.

On 01/15/2018 09:36 PM, Max Gurtovoy wrote:
>>>> ????? case NVME_CTRL_RECONNECTING:
>>>> ????????? switch (old_state) {
>>>> ????????? case NVME_CTRL_LIVE:
>>>> ????????? case NVME_CTRL_RESETTING:
>>>> +??????? case NVME_CTRL_RESET_PREPARE:
> 
> I forget to add that we shouldn't move from RESET_PREPARE to RECONNECTING (with my suggestion to rdma.c).
> Also need to consider adding another check in nvmf_check_init_req (/drivers/nvme/host/fabrics.h) for the new state.

After Sagi's nvme-rdma: fix concurrent reset and reconnect, the rdma ctrl state is changed to RECONNECTING state
after some clearing and shutdown work, then some initializing procedure,  no matter reset work path or error recovery path.
The fc reset work also does the same thing.
So if we define the range that RESET_PREPARE includes scheduling gap and disable and clear work, RESETTING includes initializing
procedure,  RECONNECTING is very similar with RESETTING.

Maybe we could do like this;
In nvme fc/rdma
- set state to RESET_PREPARE, queue reset_work/err_work 
- clear/shutdown works, set state to RECONNECTING
- initialization, set state to LIVE

In nvme pci
- set state to RESET_PREPARE, queue reset_work
- clear/shutdown works, set state to RESETTING
- initialization, set state to LIVE

Thanks
Jianchao
