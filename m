From: james.smart@broadcom.com (James Smart)
Date: Thu, 5 Jan 2017 11:21:07 -0800
Subject: Flow control in NVMf fabric host driver
In-Reply-To: <0EB3EE68A0248840B83293F49B2AACAF267713A8@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <0EB3EE68A0248840B83293F49B2AACAF267713A8@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <c55927e4-af09-6326-b807-89f79b1ee243@broadcom.com>

Santosh,

The linux transport implementations alloc a single blk_mq tag set which 
is shared for all io queues. The tag set is set to the same depth as an 
io SQ.  As such, the transport would never have more commands 
outstanding than can fit on a single SQ. Thus, there is no need for SQHD 
tracking and flow control in the host. This implementation may change in 
the future, but for now...

-- james



On 1/5/2017 2:05 AM, Santosh Singh wrote:
> Hi All,
>
> I am using the NVMf host driver and found that SQHD is not being used for SQ flow control any specific reason for same.
>
> Thanks
> Santosh
>
>
>
>
>
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
