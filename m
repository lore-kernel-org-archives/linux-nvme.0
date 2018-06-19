From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 19 Jun 2018 10:39:52 -0600
Subject: [PATCH] nvme-pci: not invoke nvme_remove_dead_ctrl when change
 state fails
In-Reply-To: <1529397050-7524-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1529397050-7524-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180619163952.GE19922@localhost.localdomain>

On Tue, Jun 19, 2018@04:30:50PM +0800, Jianchao Wang wrote:
> There is race between nvme_remove and nvme_reset_work that can
> lead to io hang.
> 
> nvme_remove                    nvme_reset_work
> -> change state to DELETING
>                                -> fail to change state to LIVE
>                                -> nvme_remove_dead_ctrl
>                                  -> nvme_dev_disable
>                                    -> quiesce request_queue
>                                  -> queue remove_work
> -> cancel_work_sync reset_work
> -> nvme_remove_namespaces
>   -> splice ctrl->namespaces
>                                nvme_remove_dead_ctrl_work
>                                -> nvme_kill_queues
>   -> nvme_ns_remove               do nothing
>     -> blk_cleanup_queue
>       -> blk_freeze_queue
> Finally, the request_queue is quiesced state when wait freeze,
> we will get io hang here.
> 
> In fact, when fails to change state in nvme_reset_work, the only
> reason is someone has changed state to DELETING. So it is not
> necessary to invoke nvme_remove_dead_ctrl in that case.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>

Good catch. I think the fix should either have the nvme_dev_disable set
shutdown to true to indicate the controller isn't coming back online, or
move the nvme_kill_queues inside nvme_remove_dead_ctrl.
