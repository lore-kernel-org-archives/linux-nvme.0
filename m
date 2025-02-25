Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2117BC021B2
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 00:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Cc:To:From:References:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tARq/I59R/ifvYF0dCCLUoCvyYc1ZBk7Dm3FuvihB2s=; b=0Iqz2DiEi92pK08LrazJ3zmg9V
	7ma38BvG4hSElBIgNpHH9tvKhBKCXYMPMFclUfa5LMSJIb0ve7OsObwZtogw3pVSWlLz6G5HKjYix
	J8BZoVY0EvuBhUbKH5zgs6fF1pjfbUQsXic1PHlIflQ+UVh3HgdqC0sdQ6oN3fb3Yxmmfdl6L76UI
	PZ8Z/jYWEtX4U7AL2uVdVCpA2vHVC/bjOTgi0f/+1ME2vkWC70TKZ0LfBmAQZb7sqwJPhF2cc7p6E
	kp9R+3xzc7hB921YdK8+tRNjQdBoN67yPbKotZtL5lt9jHsw+/Ksbe4Ds0vzcZzNdl5H/shDQsBTw
	9YWvz1wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn5jf-00000001vXg-1sED;
	Wed, 26 Feb 2025 00:57:15 +0000
Received: from smtp-80.smtpout.orange.fr ([80.12.242.80] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tn2C2-00000001Urc-0lSX;
	Tue, 25 Feb 2025 21:10:19 +0000
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id n2BftCcRTqJDFn2BitbctU; Tue, 25 Feb 2025 22:10:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740517809;
	bh=tARq/I59R/ifvYF0dCCLUoCvyYc1ZBk7Dm3FuvihB2s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=Nt/l6W83BU5mDSrDQIQy8CZKAo0h68PJvcKps3BRoVn2m6bAUl1vWhK2es/BP8BFW
	 DN3RlPUQFqJK58J49zS8Iq+H8FIQKGC4aR3FLiDA6idBgn8tIg5Twr41t+eDK/0sPp
	 mg1FQKV8UkENBVw737LGxuMBZo+ZBM/oK6VglExOrG9+5UCmVjY6kqG7UnMc6VpiKZ
	 s5Dl6bX1iLuElode1uDwU8GHn7T6IquRWeHKn8Hf+NPHn6mqYOqdxW2q2i+4k7lkXn
	 e6Eo2vgp4trckiymDN9vhHfOlmyq2Gyk1kUlSKjSw+1pc9JkNq2cH1UTJN+cQ2XgrM
	 /ezXxEpZ+Rm3Q==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 25 Feb 2025 22:10:09 +0100
X-ME-IP: 90.11.132.44
Message-ID: <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr>
Date: Tue, 25 Feb 2025 22:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/16] rbd: convert timeouts to secs_to_jiffies()
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_131018_493862_26FF493B 
X-CRM114-Status: GOOD (  16.95  )
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
> While here, remove the no-longer necessary check for range since there's
> no multiplication involved.

I'm not sure this is correct.
Now you multiply by HZ and things can still overflow.


Hoping I got casting right:

#define MSEC_PER_SEC	1000L
#define HZ 100


#define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)

static inline unsigned long _msecs_to_jiffies(const unsigned int m)
{
	return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
}

int main() {

	int n = INT_MAX - 5;

	printf("res  = %ld\n", secs_to_jiffies(n));
	printf("res  = %ld\n", _msecs_to_jiffies(1000 * n));

	return 0;
}


gives :

res  = -600
res  = 429496130

with msec, the previous code would catch the overflow, now it overflows 
silently.

untested, but maybe:
	if (result.uint_32 > INT_MAX / HZ)
		goto out_of_range;

?

CJ


> 
> Acked-by: Ilya Dryomov <idryomov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Easwar Hariharan <eahariha-1pm0nblsJy7Jp67UH1NAhkEOCMrvLtNR@public.gmane.org>
> ---
>   drivers/block/rbd.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index faafd7ff43d6ef53110ab3663cc7ac322214cc8c..41207133e21e9203192adf3b92390818e8fa5a58 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -108,7 +108,7 @@ static int atomic_dec_return_safe(atomic_t *v)
>   #define RBD_OBJ_PREFIX_LEN_MAX	64
>   
>   #define RBD_NOTIFY_TIMEOUT	5	/* seconds */
> -#define RBD_RETRY_DELAY		msecs_to_jiffies(1000)
> +#define RBD_RETRY_DELAY		secs_to_jiffies(1)
>   
>   /* Feature bits */
>   
> @@ -4162,7 +4162,7 @@ static void rbd_acquire_lock(struct work_struct *work)
>   		dout("%s rbd_dev %p requeuing lock_dwork\n", __func__,
>   		     rbd_dev);
>   		mod_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork,
> -		    msecs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT * MSEC_PER_SEC));
> +		    secs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT));
>   	}
>   }
>   
> @@ -6283,9 +6283,7 @@ static int rbd_parse_param(struct fs_parameter *param,
>   		break;
>   	case Opt_lock_timeout:
>   		/* 0 is "wait forever" (i.e. infinite timeout) */
> -		if (result.uint_32 > INT_MAX / 1000)
> -			goto out_of_range;
> -		opt->lock_timeout = msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->lock_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_pool_ns:
>   		kfree(pctx->spec->pool_ns);
> 


