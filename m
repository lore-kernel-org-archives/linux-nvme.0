From: james.smart@broadcom.com (James Smart)
Date: Fri, 4 Nov 2016 08:06:13 -0700
Subject: [PATCH v3 5/7] nvme-fabrics: Add host support for FC transport
In-Reply-To: <4640A02E-8C3E-4F98-A68C-C807D9B50ACE@cavium.com>
References: <0EBCD721-6DFC-4095-A4FC-B32F3577A985@cavium.com>
 <4640A02E-8C3E-4F98-A68C-C807D9B50ACE@cavium.com>
Message-ID: <596e6bf3-190b-a0e0-8098-1ba470dd05d9@broadcom.com>

yes - fix on its way

-- james


On 11/2/2016 5:04 PM, Trapp, Darren wrote:
> James,
>   
> There is a problem when the LDD is being removed and is completing an AEN IO with a B1 status.   The fc transport takes this goto
>          /*
>           * For the linux implementation, if we have an unsuccesful
>           * status, they blk-mq layer can typically be called with the
>           * non-zero status and the content of the cqe isn't important.
>           */
>          if (status)
>                  goto done;
>   
> Here there is no cqe to check the command_id
> done:
>          if (!queue->qnum && cqe->command_id >= AEN_CMDID_BASE) {
>    
> Since this block doesn?t execute, it calls into               blk_mq_complete_request(rq, status)  with a NULL rq.
>   
> Seems that we could either check against op->rqno (instead of cqe->command_id) or for op->rq (like start_fcp_op does).
>   
> Darren Trapp
> Senior Director - Engineering
> darren.trapp at cavium.com
> T 949-389-6273
> M 949-212-8565
> 26650 Aliso Viejo Pkwy, Aliso Viejo, CA 92656
> www.qlogic.com
>
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
