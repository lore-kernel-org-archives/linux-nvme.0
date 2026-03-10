Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2A1FD2D7B
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6aXU/df6s78vw2pBGP8k1zdxSRnKxHzcsOWIx63U+WA=; b=q7StmlBXA6efgVdbScXQla7gkQ
	4CtqFt4xmnhtR1RMxXx2xnVPXFpRqMJ88l6F0zH8ceffxK2odL5CwZ5flimBPWYnm7vIuIsfKqJTj
	7fy5sydUZPz2CEJLgXj+Pxk5XyhnGZzdZJa2Vhr3Vlej8v04sQL9yC3bO6JmgsD5a0mLltBX2vQ4q
	7MfUHYbhDJCGnh0LvCnVdjDDpU+jSD07HiXOUReq8i1a0yI8H8bSiKqi7Os9UxHUL/Tu/2SakzZN9
	Eqtt34p91f+fQ7dVU0HA3HzTu225IHC8KZgJJMPR0ZRy0p6yQOOf67RHCSjGoqA7tryPJ/taEsjLb
	rc0SPcJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzx3c-00000009aSH-1BY0;
	Tue, 10 Mar 2026 13:23:32 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzx3Z-00000009aRp-0o1w
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 13:23:30 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso3384736f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2026 06:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773149007; x=1773753807; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6aXU/df6s78vw2pBGP8k1zdxSRnKxHzcsOWIx63U+WA=;
        b=EQwb/uxsaqHl1jHUx4kvIGUce3mBvH32C/dueopNfvO3obAySR6WGqx9TUd6hU/agw
         iyLUovH0Q9G8Ti4IZ7WJxuLvdgmes4T87k1NcY/aVo5N+p+5Q611RsycHWLm02vIr0Vm
         jw8yTuPr1+klCA5TnF6hyY5Jo4GD1ugYeHUdvEdEWrN9eZnK+hdYD9uhiFv6Zp0vuPDX
         06SH4N+2p5sGx6Dlx8FZtTkQopqtJw4wJS5gCqfYykiuGZip1S/vvyel0HQqRPWhaYEy
         v8Yru8PrY1pokRtCuSxrhNOpgitA+bQOA/fryANnGJ6Gq552kKSsrKGQxetSTYHvqf/T
         E9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149007; x=1773753807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aXU/df6s78vw2pBGP8k1zdxSRnKxHzcsOWIx63U+WA=;
        b=Y3nSkO1+T9RZPPQUSQmFX/3ZeaXGv5SqRhTw4Rcw6TjxWFh2ULiiZAwFmAzB8IYMOm
         oKeRr1nLPdNGccr/vhcbiw+nADkmr6vAlsJANTCI7uReR1Mgjc283aOft5cMnzQCih+T
         Um+pd5RNW0oPlBvTgRUklPCgkhnA35V3dtUyO8Uxlqns9pVzOR7tFR+j5R6yUInK5ls6
         qXdYXdWmtNMI3bTSrzczSgqWs+SrgdHAz03ziqINBRxBHqy4QrXYMzniAuibaswM0YXh
         RU6Qz37actoOD3K1BEAxLe5ombCSf1xlkVD6YahJH8GoIAHqXU+GUib8jpXs82UDleeG
         1e6g==
X-Forwarded-Encrypted: i=1; AJvYcCXHW7/H0bOoV/oAqWAeHouv5LVgs4C9iEQ2D1DMbocb3M9XYHzETp04BCKV8NJP9qZ5/emXGdWMosS+@lists.infradead.org
X-Gm-Message-State: AOJu0Yz8rs1wEXU0b3zFeO2LZ0O+lLdND7sSmxnX/P7u8qd2galwybvy
	Zj2UB2HhrKwQTnCCQ00JT7lmj3JalbMaCfHnCZcb9Y3AAFLtOTL67pRrfeAw6FQMeUM=
X-Gm-Gg: ATEYQzxWykWTAf32v3e9BnIozuT5jnKq9DRaRM5+rkNRi+P5H3K3arHja7ZjuQXo1Y6
	1qtdXo6JU2QA9IwrsPKa3V5HNAQTiw2MuQQQX/9ah0w3gbyC9p73IWPI7Q8PCim9apdpo0FPeVR
	nlANk9eC9I/rAxAmtjmsKqSEUNuY/EjbYeusf5keNlRIxfFW/cGYHnyXOqw42AbryQCTBBJx/b4
	ZIAPC/hGxmMjWGO3qcJ9WGtNJsgMVqx1iujgUYT2SpvwDrQLBNlzveziiEMCgLxxMNN1JA0mv3u
	fGzr9nGCvxCGa5NwTbYC4iLla1OpXdHCwNPG1+/LEYN+IF/ZdUotfB+pmQ33bJVPyZ3DWDNyIV6
	YzTBl+KzIi7rzfctFzurvSsn67D3CCCqh1Uh422aKC80xqUwu7lbpugvQGRj1MxLE/BYrLzKljt
	m8I8+bZPpQhOmPtUD4XGwkbHKh3S/uyanK1BtszQUDzIW3d8vZjA1q4rFa
X-Received: by 2002:a05:6000:2506:b0:439:ae2a:755e with SMTP id ffacd0b85a97d-439da35fa91mr26956544f8f.23.1773149006537;
        Tue, 10 Mar 2026 06:23:26 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3c80esm32266361f8f.29.2026.03.10.06.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 06:23:26 -0700 (PDT)
Message-ID: <f46807c2-0266-4143-9caa-ff938293f7b4@suse.com>
Date: Tue, 10 Mar 2026 14:23:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] scsi: scsi-multipath: Add basic ALUA support
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
 martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
 bmarzins@redhat.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 axboe@fb.com, linux-scsi@vger.kernel.org, michael.christie@oracle.com,
 snitzer@kernel.org, dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 nilay@linux.ibm.com
References: <20260310114925.1222263-1-john.g.garry@oracle.com>
 <20260310114925.1222263-6-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260310114925.1222263-6-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_062329_304672_3E5C9C11 
X-CRM114-Status: GOOD (  38.79  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/10/26 12:49, John Garry wrote:
> Add basic support just to get the per-port group state.
> 
> This support does not account of state transitioning, sdev port group
> reconfiguration, etc, required for full support.
> 
> libmultipath callbacks scsi_mpath_is_optimized() and
> scsi_mpath_is_disabled() are updated to take account of the ALUA-provided
> path information.
> 
> As before, for no ALUA support (and scsi_multipath_always on) we assume
> that the paths are all optimized.
> 
> Much of this code in scsi_mpath_alua_init() is copied from scsi_dh_alua.c,
> originally authored by Hannes Reinecke.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/scsi_multipath.c | 163 ++++++++++++++++++++++++++++++++--
>   include/scsi/scsi_multipath.h |   3 +
>   2 files changed, 160 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
> index 1489c7e979167..0a314080bf0a5 100644
> --- a/drivers/scsi/scsi_multipath.c
> +++ b/drivers/scsi/scsi_multipath.c
> @@ -4,6 +4,7 @@
>    *
>    */
>   
> +#include <scsi/scsi_alua.h>
>   #include <scsi/scsi_cmnd.h>
>   #include <scsi/scsi_driver.h>
>   #include <scsi/scsi_proto.h>
> @@ -346,18 +347,29 @@ static bool scsi_mpath_is_disabled(struct mpath_device *mpath_device)
>   				to_scsi_mpath_device(mpath_device);
>   	struct scsi_device *sdev = scsi_mpath_dev->sdev;
>   	enum scsi_device_state sdev_state = sdev->sdev_state;
> +	int alua_state = scsi_mpath_dev->alua_state;
>   
>   	if (sdev_state == SDEV_RUNNING || sdev_state == SDEV_CANCEL)
>   		return false;
>   
> -	return true;
> +	if (alua_state == SCSI_ACCESS_STATE_OPTIMAL ||
> +	    alua_state == SCSI_ACCESS_STATE_ACTIVE)
> +		return true;
> +
> +	return false;
>   }
>   
>   static bool scsi_mpath_is_optimized(struct mpath_device *mpath_device)
>   {
> +	struct scsi_mpath_device *scsi_mpath_dev =
> +				to_scsi_mpath_device(mpath_device);
> +
>   	if (scsi_mpath_is_disabled(mpath_device))
>   		return false;
> -	return true;
> +	if (scsi_mpath_dev->alua_state == SCSI_ACCESS_STATE_OPTIMAL)
> +		return true;
> +	return false;
> +
>   }
>   
>   /* Until we have ALUA support, we're always optimised */
> @@ -366,7 +378,7 @@ static enum mpath_access_state scsi_mpath_get_access_state(
>   {
>   	if (scsi_mpath_is_disabled(mpath_device))
>   		return MPATH_STATE_INVALID;
> -	return MPATH_STATE_OPTIMIZED;
> +	return scsi_mpath_is_optimized(mpath_device);
>   }
>   
>   static bool scsi_mpath_available_path(struct mpath_device *mpath_device, bool *available)
> @@ -579,16 +591,147 @@ static void scsi_multipath_sdev_uninit(struct scsi_device *sdev)
>   	sdev->scsi_mpath_dev = NULL;
>   }
>   
> +static int scsi_mpath_alua_init(struct scsi_device *sdev)
> +{
> +	struct scsi_mpath_device *scsi_mpath_dev = sdev->scsi_mpath_dev;
> +	struct scsi_sense_hdr sense_hdr;
> +	int len, k, off, bufflen = ALUA_RTPG_SIZE;
> +	unsigned char *desc, *buff;
> +	unsigned int tpg_desc_tbl_off;
> +	int group_id, rel_port = -1;
> +	bool ext_hdr_unsupp = false;
> +	int ret;
> +
> +	group_id = scsi_vpd_tpg_id(sdev, &rel_port);
> +	if (group_id < 0) {
> +		/*
> +		 * Internal error; TPGS supported but required
> +		 * VPD identification descriptors not present.
> +		 * Disable ALUA support.
> +		 */
> +		sdev_printk(KERN_INFO, sdev,
> +			    "%s: No target port descriptors found\n",
> +			    __func__);
> +		return -EIO;
> +	}
> +
> +	buff = kzalloc(bufflen, GFP_KERNEL);
> +	if (!buff)
> +		return -ENOMEM;
> + retry:
> +	ret = submit_rtpg(sdev, buff, bufflen, &sense_hdr,
> +				ext_hdr_unsupp);
> +
> +	if (ret) {
> +		if (ret < 0 || !scsi_sense_valid(&sense_hdr)) {
> +			sdev_printk(KERN_INFO, sdev,
> +				    "%s: rtpg failed, result %d\n",
> +				    __func__, ret);
> +			kfree(buff);
> +			if (ret < 0)
> +				return -EBUSY;
> +			if (host_byte(ret) == DID_NO_CONNECT)
> +				return -ENODEV;
> +			return -EIO;
> +		}
> +
> +		/*
> +		 * submit_rtpg() has failed on existing arrays
> +		 * when requesting extended header info, and
> +		 * the array doesn't support extended headers,
> +		 * even though it shouldn't according to T10.
> +		 * The retry without rtpg_ext_hdr_req set
> +		 * handles this.
> +		 * Note:  some arrays return a sense key of ILLEGAL_REQUEST
> +		 * with ASC 00h if they don't support the extended header.
> +		 */
> +		if (ext_hdr_unsupp &&
> +		    sense_hdr.sense_key == ILLEGAL_REQUEST) {
> +			ext_hdr_unsupp = true;
> +			goto retry;
> +		}
> +		/*
> +		 * If the array returns with 'ALUA state transition'
> +		 * sense code here it cannot return RTPG data during
> +		 * transition. So set the state to 'transitioning' directly.
> +		 */
> +		if (sense_hdr.sense_key == NOT_READY &&
> +		    sense_hdr.asc == 0x04 && sense_hdr.ascq == 0x0a)
> +			goto out;
> +
> +		/*
> +		 * Retry on any other UNIT ATTENTION occurred.
> +		 */
> +		if (sense_hdr.sense_key == UNIT_ATTENTION) {
> +			scsi_print_sense_hdr(sdev, __func__, &sense_hdr);
> +			kfree(buff);
> +			return -EAGAIN;
> +		}
> +		sdev_printk(KERN_ERR, sdev, "%s: rtpg failed\n",
> +			    __func__);
> +		scsi_print_sense_hdr(sdev, __func__, &sense_hdr);
> +		kfree(buff);
> +		return -EIO;
> +	}
> +
> +	len = get_unaligned_be32(&buff[0]) + 4;
> +
> +	if (len > bufflen) {
> +		/* Resubmit with the correct length */
> +		kfree(buff);
> +		bufflen = len;
> +		buff = kmalloc(bufflen, GFP_KERNEL);
> +		if (!buff) {
> +			/* Temporary failure, bypass */
> +			return -EBUSY;
> +		}
> +		goto retry;
> +	}
> +
> +	if ((buff[4] & RTPG_FMT_MASK) == RTPG_FMT_EXT_HDR)
> +		tpg_desc_tbl_off = 8;
> +	else
> +		tpg_desc_tbl_off = 4;
> +
> +	for (k = tpg_desc_tbl_off, desc = buff + tpg_desc_tbl_off;
> +	     k < len;
> +	     k += off, desc += off) {
> +		u16 group_id_found = get_unaligned_be16(&desc[2]);
> +
> +		if (group_id_found == group_id) {
> +			int valid_states, state, pref;
> +
> +			state = desc[0] & 0x0f;
> +			pref = desc[0] >> 7;
> +			valid_states = desc[1];
> +
> +			alua_print_info(sdev, group_id, state, pref, valid_states);
> +
> +			scsi_mpath_dev->alua_state = state;
> +			scsi_mpath_dev->alua_pref = pref;
> +			scsi_mpath_dev->alua_valid_states = valid_states;
> +			goto out;
> +		}
> +
> +		off = 8 + (desc[7] * 4);
> +	}
> +
> +out:
> +	kfree(buff);
> +	return 0;
> +}
> +
>   int scsi_mpath_dev_alloc(struct scsi_device *sdev)
>   {
>   	struct scsi_mpath_head *scsi_mpath_head;
> -	int ret;
> +	int ret, tpgs;
>   
>   	if (!scsi_multipath)
>   		return 0;
>   
> -	if (!scsi_device_tpgs(sdev) && !scsi_multipath_always) {
> -		sdev_printk(KERN_NOTICE, sdev, "tpgs are required for multipath support\n");
> +	tpgs = alua_check_tpgs(sdev);
> +	if (!(tpgs & TPGS_MODE_IMPLICIT) && !scsi_multipath_always) {
> +		sdev_printk(KERN_DEBUG, sdev, "IMPLICIT TPGS are required for multipath support\n");
>   		return 0;
>   	}
>   
> @@ -622,6 +765,14 @@ int scsi_mpath_dev_alloc(struct scsi_device *sdev)
>   	sdev->scsi_mpath_dev->scsi_mpath_head = scsi_mpath_head;
>   
>   found:
> +	if (tpgs & TPGS_MODE_IMPLICIT) {
> +		ret = scsi_mpath_alua_init(sdev);
> +		if (ret)
> +			goto out_put_head;
> +	} else {
> +		sdev->scsi_mpath_dev->alua_state = SCSI_ACCESS_STATE_OPTIMAL;
> +	}
> +
>   	sdev->scsi_mpath_dev->index = ida_alloc(&scsi_mpath_head->ida, GFP_KERNEL);
>   	if (sdev->scsi_mpath_dev->index < 0) {
>   		ret = sdev->scsi_mpath_dev->index;
> diff --git a/include/scsi/scsi_multipath.h b/include/scsi/scsi_multipath.h
> index 2011447f482d6..7c7ee2fb7def7 100644
> --- a/include/scsi/scsi_multipath.h
> +++ b/include/scsi/scsi_multipath.h
> @@ -38,6 +38,9 @@ struct scsi_mpath_device {
>   	int			index;
>   	atomic_t		nr_active;
>   	struct scsi_mpath_head	*scsi_mpath_head;
> +	int			alua_state;
> +	int			alua_pref;
> +	int			alua_valid_states;
>   
>   	char			device_id_str[SCSI_MPATH_DEVICE_ID_LEN];
>   };

Is there a specific reason why this cannot be in the generic code?
After all, if the device reports anything else than ALUA_STATE_OPTIMAL
or ALUA_STATE_ACTIVE I/O will fail, irrespective of multipath being
active.

I would love to see that in the generic SCSI code, independent on this 
patchset. It would allow us to simplify the device handler code, too,
as then device handler really would only be required for explicit
ALUA. (And could be ignored for scsi-multipathing).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

