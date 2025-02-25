Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024EBC021BF
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 00:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CDOnVbuHRa5TlckniZ+QbcxrKwAHtppPzAjAscxNHSY=; b=fAiAML8N/17EMUY3O5KtxV3PO2
	m2rFvSd3Ci/jEh46PFb4JwsK0YbzPulMfkE0RwvP/rt6usbL07hiJCPT/3y57k1IyVXUl4pyNIs20
	xmZhrKwyScr1HuRmE1EHnLMIewoI2FsxfCTzBevznZCv/nkxIEhoAeb/yTWLJZ6L+Xhda6Vvoobz0
	muY1thr5Kb3jtE/xNX+csg3YtWrZaAZMtHlFsR3WOAf+VzqeoKCkAQL2sqgT+p/nK+3H6n1+y50UF
	C9Mw5cUVcILjCCytK9odU+rw9c/GTfqA1CopyPG0lEEHi6YE/l33Ra77Xh0Ll5J3KwtsAehdzlM55
	DL6GaG5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn5jg-00000001vZh-1E0p;
	Wed, 26 Feb 2025 00:57:16 +0000
Received: from smtp-71.smtpout.orange.fr ([80.12.242.71] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tn2RE-00000001Xfw-2yKw;
	Tue, 25 Feb 2025 21:26:02 +0000
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id n2R0tkeFQ4iG7n2R3t60Fm; Tue, 25 Feb 2025 22:25:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740518758;
	bh=CDOnVbuHRa5TlckniZ+QbcxrKwAHtppPzAjAscxNHSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=siYU52+wZ9L1fww+iQDN9rtYX6/aPczL9atUE2l26+nq1Ri8dh3TYGdKOZSOl8FUk
	 XrbU+P2TpuXPZmylEcNVhm7IGsserFCZYBNjOT562ZUYjLqKjMa1SJH893MOHidh6R
	 OQATR7VDki3fiHZfHEF2JqtwL04PZvB0Oj0pypFUs2f2NaghtKWNKg5zY+oKMy9gx3
	 hJDV0lXDGXzAw1PjH65vHLOKoP3lFuSvJzAbZkaII3cDH1jfDHrdCDL8+lHftSY/+S
	 CY90Fz3FaFYxcLZzbR4khlsrjLfgaLUxO0uOmAn+6ltyDhAKQJ99yzzK2ZVeFXSo2U
	 OrHC+r+ja1CFQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 25 Feb 2025 22:25:58 +0100
X-ME-IP: 90.11.132.44
Message-ID: <44dd2b5b-d91c-4daf-ab75-ed4030180028@wanadoo.fr>
Date: Tue, 25 Feb 2025 22:25:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/16] libceph: convert timeouts to secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Frank.Li@nxp.com, James.Bottomley@HansenPartnership.com,
 Julia.Lawall@inria.fr, Shyam-sundar.S-k@amd.com, akpm@linux-foundation.org,
 axboe@kernel.dk, broonie@kernel.org, cassel@kernel.org, cem@kernel.org,
 ceph-devel@vger.kernel.org, clm@fb.com, cocci@inria.fr,
 dick.kennedy@broadcom.com, djwong@kernel.org, dlemoal@kernel.org,
 dongsheng.yang@easystack.cn, dri-devel@lists.freedesktop.org,
 dsterba@suse.com, festevam@gmail.com, hch@lst.de, hdegoede@redhat.com,
 hmh@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, idryomov@gmail.com,
 ilpo.jarvinen@linux.intel.com, imx@lists.linux.dev,
 james.smart@broadcom.com, jgg@ziepe.ca, josef@toxicpanda.com,
 kalesh-anakkur.purayil@broadcom.com, kbusch@kernel.org,
 kernel@pengutronix.de, leon@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org,
 martin.petersen@oracle.com, nicolas.palix@imag.fr, ogabbay@kernel.org,
 perex@perex.cz, platform-driver-x86@vger.kernel.org, s.hauer@pengutronix.de,
 sagi@grimberg.me, selvin.xavier@broadcom.com, shawnguo@kernel.org,
 sre@kernel.org, tiwai@suse.com, xiubli@redhat.com, yaron.avizrat@intel.com
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-7-a43967e36c88@linux.microsoft.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-7-a43967e36c88@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_132600_884603_F8481154 
X-CRM114-Status: GOOD (  15.52  )
X-Mailman-Approved-At: Tue, 25 Feb 2025 16:56:55 -0800
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

Le 25/02/2025 à 21:17, Easwar Hariharan a écrit :
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@ expression E; @@
> 
> -msecs_to_jiffies(E * 1000)
> +secs_to_jiffies(E)
> 
> @depends on patch@ expression E; @@
> 
> -msecs_to_jiffies(E * MSEC_PER_SEC)
> +secs_to_jiffies(E)
> 
> While here, remove the no-longer necessary checks for range since there's
> no multiplication involved.

No sure it is correct.

Same comment as on patch 06/16, available at [1].

CJ

[1]: 
https://lore.kernel.org/linux-kernel/e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr/

> 
> Acked-by: Ilya Dryomov <idryomov@gmail.com>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>   include/linux/ceph/libceph.h | 12 ++++++------
>   net/ceph/ceph_common.c       | 18 ++++++------------
>   net/ceph/osd_client.c        |  3 +--
>   3 files changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 733e7f93db66a7a29a4a8eba97e9ebf2c49da1f9..5f57128ef0c7d018341c15cc59288aa47edec646 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -72,15 +72,15 @@ struct ceph_options {
>   /*
>    * defaults
>    */
> -#define CEPH_MOUNT_TIMEOUT_DEFAULT	msecs_to_jiffies(60 * 1000)
> -#define CEPH_OSD_KEEPALIVE_DEFAULT	msecs_to_jiffies(5 * 1000)
> -#define CEPH_OSD_IDLE_TTL_DEFAULT	msecs_to_jiffies(60 * 1000)
> +#define CEPH_MOUNT_TIMEOUT_DEFAULT	secs_to_jiffies(60)
> +#define CEPH_OSD_KEEPALIVE_DEFAULT	secs_to_jiffies(5)
> +#define CEPH_OSD_IDLE_TTL_DEFAULT	secs_to_jiffies(60)
>   #define CEPH_OSD_REQUEST_TIMEOUT_DEFAULT 0  /* no timeout */
>   #define CEPH_READ_FROM_REPLICA_DEFAULT	0  /* read from primary */
>   
> -#define CEPH_MONC_HUNT_INTERVAL		msecs_to_jiffies(3 * 1000)
> -#define CEPH_MONC_PING_INTERVAL		msecs_to_jiffies(10 * 1000)
> -#define CEPH_MONC_PING_TIMEOUT		msecs_to_jiffies(30 * 1000)
> +#define CEPH_MONC_HUNT_INTERVAL		secs_to_jiffies(3)
> +#define CEPH_MONC_PING_INTERVAL		secs_to_jiffies(10)
> +#define CEPH_MONC_PING_TIMEOUT		secs_to_jiffies(30)
>   #define CEPH_MONC_HUNT_BACKOFF		2
>   #define CEPH_MONC_HUNT_MAX_MULT		10
>   
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 4c6441536d55b6323f4b9d93b5d4837cd4ec880c..c2a2c3bcc4e91a628c99bd1cef1211d54389efa2 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -527,29 +527,23 @@ int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
>   
>   	case Opt_osdkeepalivetimeout:
>   		/* 0 isn't well defined right now, reject it */
> -		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
> +		if (result.uint_32 < 1)
>   			goto out_of_range;
> -		opt->osd_keepalive_timeout =
> -		    msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->osd_keepalive_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_osd_idle_ttl:
>   		/* 0 isn't well defined right now, reject it */
> -		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
> +		if (result.uint_32 < 1)
>   			goto out_of_range;
> -		opt->osd_idle_ttl = msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->osd_idle_ttl = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_mount_timeout:
>   		/* 0 is "wait forever" (i.e. infinite timeout) */
> -		if (result.uint_32 > INT_MAX / 1000)
> -			goto out_of_range;
> -		opt->mount_timeout = msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->mount_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_osd_request_timeout:
>   		/* 0 is "wait forever" (i.e. infinite timeout) */
> -		if (result.uint_32 > INT_MAX / 1000)
> -			goto out_of_range;
> -		opt->osd_request_timeout =
> -		    msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->osd_request_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   
>   	case Opt_share:
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index b24afec241382b60d775dd12a6561fa23a7eca45..ba61a48b4388c2eceb5b7a299906e7f90191dd5d 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -4989,8 +4989,7 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
>   	linger_submit(lreq);
>   	ret = linger_reg_commit_wait(lreq);
>   	if (!ret)
> -		ret = linger_notify_finish_wait(lreq,
> -				 msecs_to_jiffies(2 * timeout * MSEC_PER_SEC));
> +		ret = linger_notify_finish_wait(lreq, secs_to_jiffies(2 * timeout));
>   	else
>   		dout("lreq %p failed to initiate notify %d\n", lreq, ret);
>   
> 


