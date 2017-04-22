From: yizhan@redhat.com (Yi Zhang)
Date: Sat, 22 Apr 2017 04:09:57 -0400 (EDT)
Subject: iwpm_register_pid: Unable to send a nlmsg (client = 2) observed on
 4.11.0-rc7 during configure NVMe over iWARP RDMA
In-Reply-To: <1613368219.36836.1492847910707.JavaMail.zimbra@redhat.com>
Message-ID: <770183667.36997.1492848597368.JavaMail.zimbra@redhat.com>

Hello experts

I found below pid_query_error, could anyone help check it? I have attached all the dmesg log. Thanks

[  152.372481] nvmet: adding nsid 1 to subsystem testnqn
[  152.398705] iwpm_register_pid: Unable to send a nlmsg (client = 2)
[  152.430011] nvmet_rdma: enabling port 2 (172.31.52.12:4420)


Best Regards,
  Yi Zhang


-------------- next part --------------
A non-text attachment was scrubbed...
Name: dmesg.log
Type: text/x-log
Size: 65341 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170422/92671ff3/attachment-0001.bin>
