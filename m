From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 24 Apr 2017 10:58:48 -0500
Subject: iwpm_register_pid: Unable to send a nlmsg (client = 2) observed
 on 4.11.0-rc7 during configure NVMe over iWARP RDMA
In-Reply-To: <770183667.36997.1492848597368.JavaMail.zimbra@redhat.com>
References: <1613368219.36836.1492847910707.JavaMail.zimbra@redhat.com>
 <770183667.36997.1492848597368.JavaMail.zimbra@redhat.com>
Message-ID: <09c501d2bd13$a8d58700$fa809500$@opengridcomputing.com>

> Subject: iwpm_register_pid: Unable to send a nlmsg (client = 2) observed on 4.11.0-
> rc7 during configure NVMe over iWARP RDMA
> 
> Hello experts
> 
> I found below pid_query_error, could anyone help check it? I have attached all the
> dmesg log. Thanks
> 
> [  152.372481] nvmet: adding nsid 1 to subsystem testnqn
> [  152.398705] iwpm_register_pid: Unable to send a nlmsg (client = 2)
> [  152.430011] nvmet_rdma: enabling port 2 (172.31.52.12:4420)
> 
> 
> Best Regards,
>   Yi Zhang
>

Hey Yi, 

This is the iWARP port mapping kernel service logging that no iwarp port mapper daemon is running on the system.  This is benign in the context of nvme/fabrics.  Are you having other problems with using iw_cxgb4?

Steve.
 
