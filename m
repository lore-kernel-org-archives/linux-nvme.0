Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044FDD111A8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 22:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yMQdkwEGltQT1kiQBH8SMDmrca9g5J3dj5IS1xLfgtA=; b=jR1U17fxte1La9gjiDBQHYZ5GR
	YtSr8x/dpVOKO4HQb9oN8u0fUQeiLzFvD3a8uVuFR9OscetIYppxgfwhe20GvkswHU48aI8gfZjqg
	phKajKvRN9RFF3CrCiHhiryzIQfaXoJa+viJr90sVKK0CmE9A4XNRNsF3OAFqGJ300xDuPwlt5GpD
	jJgqsSjy+MkUKvuWaxoR/vXu3Os9ndzEJhAjf7Ezz0GnJc4gvayac7Ohulr+pD9MSksPmdvAMwBIT
	RLmcg0KYNTLKrI58oHKwnpIj+qkbbc+YhbYZb3G58aWb2TlV1OmYJttyNhsjWsAqFHzhjc+WCOC55
	RLVCFTUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpYh-00000002bel-1Q3N;
	Sun, 30 Nov 2025 22:06:19 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpYe-00000002beC-3e9c
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 22:06:17 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so24322255e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 14:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764540375; x=1765145175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMQdkwEGltQT1kiQBH8SMDmrca9g5J3dj5IS1xLfgtA=;
        b=TxxJfjIHnV38RuZsprngWWHcSCSIU9TArVYfrm+aA7eVZVQzeEKz9sHxQHViDY+CZk
         5sry6lK48TyCDCqtwXVhK8v8eWljlHShlXbtKyEakz/Trsl5LTwkvFFqAos3oAmfa0cK
         /e05j4tM2O+d8JVjO4eWEpc9QX4QhYPVS6Ogw0kN6QWr8BJPAZ24zZZG4I78DELakz06
         K/mN0CK3qL1ZewAVFSBqF28g3t0LrAZAMzrbzS0BWjv+kmNbPtbUD5YCtdDbsdMJVYA+
         HBb7a0fTTbpT9vFcyCJnMabia5+IMp1pyjCpfkDN48BZqUH10AMkcupIvSw+OqWrZLBn
         r8hA==
X-Forwarded-Encrypted: i=1; AJvYcCXt5dphpNhWPqjrWezQxdWZRcSIV4vSQRZQwX2N5RsRbOaozNG09sJRkQZwRtYiAi3/rT2HLBdYyT3I@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0wCV2HrYjkBKq6daONhTIUjrSm/WldNH5gukkVASIKN1/KhgL
	L3BdcGNmPVX30mMLdkED5jw81twFL3jvAAMQhLOGxfhjnyjHWr7O26pFXEA/6w==
X-Gm-Gg: ASbGncvo+KngUYtIJf09/4dA0MsMZqDu+P3WvDmRGe4Pn9h7tJraGPzo94I6/ufww0V
	9TQ4igL3enBYP9iM3ejC3mOneHYqLfm9Y7ea+Bd2u6EuIEX4m1f9PNPg4kbVoFbXUYD/hQMSCsM
	ia/yCnym8yNUXzNrqGZK+IUmN7MJDZ6zViGgN/i8VJugEKa5AIrX6q6jagBqm8FofYdiK0S779b
	KYojgaJgpv9rUPTfS15vsB4fhsvSHgu1++2SMYWFBdGj5oX2L3UYkt7BIeaJrcYHFwM6DqLxv+Q
	NDfwcek+nuufzTg95VKO6DhoHa2/ky7K+0zyrMpejKIof14CSbXPcRPkJYwPAGRH/S4CRLpfU7x
	505+AFhFpjsOXsd7xQ4m/dd8lAYnkO+dkFM4azLk6ihOSK04odv2mJuVfVpOrCVuUeaVEHbiCqW
	JF5dmlnpV/juaa/E3QHDRnHqm8CdrumBJNodF+rCpi
X-Google-Smtp-Source: AGHT+IHVgfkobxp51/d5dH4wU5Abni+DkVEdkcwhWuQpbYNOZtp3QYQsmBSjw2EgsaCJ9Eyss8Y2Vw==
X-Received: by 2002:a05:600c:1f0f:b0:477:7b30:a6fc with SMTP id 5b1f17b1804b1-47904b2484amr238161705e9.30.1764540374734;
        Sun, 30 Nov 2025 14:06:14 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c30c4sm22944528f8f.9.2025.11.30.14.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:06:14 -0800 (PST)
Message-ID: <7567cbdc-440e-4e58-bb54-87879c004601@grimberg.me>
Date: Mon, 1 Dec 2025 00:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] nvme: allow to pass in key description as dhchap
 secret
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-7-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250528140517.3284-7-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_140616_929156_79BC316E 
X-CRM114-Status: GOOD (  23.74  )
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



On 28/05/2025 17:05, Hannes Reinecke wrote:
> In order to use pre-populated keys update the parsing for
> DH-HMAC-CHAP secret to allow for a key description instead
> of an encoded binary secret.

Would it be possible to paste an example "dhchap_secret=%s"
for before and after?

>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/common/auth.c     | 15 ++++++---
>   drivers/nvme/host/auth.c       | 17 ++++++++--
>   drivers/nvme/host/fabrics.c    | 24 ++++++++++----
>   drivers/nvme/host/fabrics.h    |  4 +++
>   drivers/nvme/host/nvme.h       |  2 ++
>   drivers/nvme/host/sysfs.c      | 60 ++++++++++++++++++++++------------
>   drivers/nvme/target/auth.c     | 20 ++++++++++--
>   drivers/nvme/target/configfs.c | 10 +++---
>   drivers/nvme/target/nvmet.h    |  2 ++
>   include/linux/nvme-auth.h      |  3 +-
>   10 files changed, 116 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 8c2ccbfb9986..cbf35a7c3105 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -156,14 +156,21 @@ size_t nvme_auth_hmac_hash_len(u8 hmac_id)
>   EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
>   
>   struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
> -				  size_t secret_len)
> +				  size_t secret_len, bool *generated)
>   {
>   	struct key *key;
>   
> +	key = nvme_dhchap_psk_lookup(keyring, secret);
> +	if (!IS_ERR(key)) {
> +		*generated = false;
> +		return key;
> +	}
>   	key = nvme_dhchap_psk_refresh(keyring, secret, secret_len);
> -	if (!IS_ERR(key))
> -		pr_debug("generated dhchap key %08x\n",
> -			 key_serial(key));
> +	if (!IS_ERR(key)) {
> +		*generated = true;

Can you explain what exactly is being "generated" here?

Is this intermediate key you are generating is because the
user passed in a legacy dhchap_secret?

If this is the case, can we please wrap this call in something like:
nvme_auth_extract_key_legacy() and head it with some documentation?
also the patch description should discuss this. It is not easy to understand
from simply reading the code.

> +		pr_debug("generated dhchap key %s\n",
> +			 key->description);
> +	}
>   	return key;
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 0e8a5b544f63..0464e23b2a21 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -1057,19 +1057,29 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
>   static void nvme_auth_clear_key(struct nvme_ctrl *ctrl, bool is_ctrl)
>   {
>   	struct key *key;
> +	bool generated;
>   
>   	if (is_ctrl) {
>   		key = ctrl->ctrl_key;
>   		ctrl->ctrl_key = NULL;
> +		generated = ctrl->ctrl_key_generated;
> +		ctrl->ctrl_key_generated = false;
>   	} else {
>   		key = ctrl->host_key;
>   		ctrl->host_key = NULL;
> +		generated = ctrl->host_key_generated;
> +		ctrl->host_key_generated = false;
>   	}
>   	if (key) {
> -		dev_dbg(ctrl->device, "%s: revoke%s key %08x\n",
> +		if (generated) {
> +			dev_dbg(ctrl->device, "%s: revoke%s key %08x\n",
> +				__func__, is_ctrl ? " ctrl" : "",
> +				key_serial(key));
> +			key_revoke(key);
> +		}
> +		dev_dbg(ctrl->device, "%s: drop%s key %08x\n",
>   			__func__, is_ctrl ? " ctrl" : "",
>   			key_serial(key));
> -		key_revoke(key);
>   		key_put(key);
>   	}
>   }
> @@ -1099,6 +1109,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>   			 key_serial(ctrl->opts->dhchap_key));
>   		return -ENOKEY;
>   	}
> +	ctrl->host_key_generated = ctrl->opts->dhchap_key_generated;

Why do we have this in both ctrl and opts? this is very very confusing.
  I think I mentioned this before, I really don't think that we should 
be adding state to opts.
opts is intended to store user opts and state should remain under ctrl.


