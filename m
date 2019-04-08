From: james.smart@broadcom.com (James Smart)
Date: Mon, 8 Apr 2019 09:37:51 -0700
Subject: FC-NVMe csn initialisation
In-Reply-To: <210FF865-6562-4404-A47D-E38EDD5D9B00@netapp.com>
References: <7f105083-7e74-7191-d321-acdeafa25f88@suse.de>
 <210FF865-6562-4404-A47D-E38EDD5D9B00@netapp.com>
Message-ID: <e1d5b88f-218c-e556-6053-93a6c3aeda8b@broadcom.com>



On 4/8/2019 8:45 AM, Meneghini, John wrote:
>> a) the CSN shall be equal to zero for the first NVMe_CMND IU for each
>>     NVMeoFC connection and shall be incremented by one for each subsequent
>>     command on the NVMeoFC connection;
> I'm not sure it matters if the csn starts at 0. As long as the csn is incremented with every FC_CMD_IU that's put on the wire, I think we're good.
>
> However, I do think I see a bug were nvme_fc_start_fcp_op() increments the queue->csn counter and then never puts the cmdiu on the transport queue.
>
> This can happen when nvme_fc_map_data() returns an error.
>
> /John
>
> static blk_status_t
> nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>          struct nvme_fc_fcp_op *op, u32 data_len,
>          enum nvmefc_fcp_datadir io_dir)
> {
>          struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
>          struct nvme_command *sqe = &cmdiu->sqe;
>          u32 csn;
>          int ret, opstate;
>     ...
>          /* format the FC-NVME CMD IU and fcp_req */
>          cmdiu->connection_id = cpu_to_be64(queue->connection_id);
>          csn = atomic_inc_return(&queue->csn);
>          cmdiu->csn = cpu_to_be32(csn);
>    ...
>          if (!(op->flags & FCOP_FLAGS_AEN)) {
>                  ret = nvme_fc_map_data(ctrl, op->rq, op);
>                  if (ret < 0) {
>                          nvme_cleanup_cmd(op->rq);
>                          nvme_fc_ctrl_put(ctrl);
>                          if (ret == -ENOMEM || ret == -EAGAIN)
>                                  return BLK_STS_RESOURCE;
>                          return BLK_STS_IOERR;
>                  }
>          }
>     ...
>          ret = ctrl->lport->ops->fcp_io(&ctrl->lport->localport,
>                                          &ctrl->rport->remoteport,
>                                          queue->lldd_handle, &op->fcp_req);
>
>
> ?On 4/8/19, 4:38 AM, "Hannes Reinecke" <hare@suse.de> wrote:
>      
>      Hi James,
>      
>      checking the FC-NVMe spec it states:
>      
>      a) the CSN shall be equal to zero for the first NVMe_CMND IU for each
>      NVMeoFC connection and shall be incremented by one for each subsequent
>      command on the NVMeoFC connection;
>      
>      yet we have:
>      
>      static void
>      nvme_fc_init_queue(struct nvme_fc_ctrl *ctrl, int idx)
>      {
>              struct nvme_fc_queue *queue;
>      
>              queue = &ctrl->queues[idx];
>              memset(queue, 0, sizeof(*queue));
>              queue->ctrl = ctrl;
>              queue->qnum = idx;
>              atomic_set(&queue->csn, 1);
>              queue->dev = ctrl->dev;
>      
>      Is this by design?
>      Or a simple bug?
>      
>      Cheers,
>      
>      Hannes
>      --
>      Dr. Hannes Reinecke                Teamlead Storage & Networking
>      hare at suse.de                                   +49 911 74053 688
>      SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
>      GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
>      HRB 21284 (AG N?rnberg)
>      
>

Good question. I believe a simple bug from a long time ago. The target 
side, for the most part, doesn't care about what the csn is until a 
fused io comes, then it would has to use the csn to pair them up.? As 
linux never sends fuse ios, csn is effectively irrelevant when used with 
linux.? If one were to be "spec compliant" yes, the target could choose 
to validate the connect cmd had cmdiu=0. But for any other command on 
the connection, order isn't dictated so there's no way to guess what the 
csn should be.

And I do agree with John. I'll send a patchup shortly.

-- james
