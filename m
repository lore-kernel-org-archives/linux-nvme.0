From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 Jan 2015 23:10:07 +0000 (UTC)
Subject: [PATCHv3 for-3.20] NVMe: Update SCSI Inquiry VPD 83h translation
In-Reply-To: <1420757697-14839-1-git-send-email-keith.busch@intel.com>
References: <1420757697-14839-1-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.LNX.2.00.1501082307010.4026@localhost.lm.intel.com>

Sorry, I submitted the patch from my dev machine, not the patch from the
tested machine. The designator type is incorrect here, but the attached
patch is correct. Only difference is using designator type 2h instead
of 3h.

On Thu, 8 Jan 2015, Keith Busch wrote:
> +		inq_response[4] = 0x01;    /* Proto ID=0h | Code set=1h */
> +		inq_response[5] = 0x03;    /* PIV=0b | Asso=00b | Designator Type=3h */
> +		inq_response[6] = 0x00;    /* Rsvd */
> +		inq_response[7] = len;     /* Designator Length */
> +		memcpy(&inq_response[8], eui, len);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-NVMe-Update-SCSI-Inquiry-VPD-83h-translation.patch
Type: text/x-patch
Size: 6949 bytes
Desc: Correct Patch
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20150108/758d19e1/attachment.bin>
