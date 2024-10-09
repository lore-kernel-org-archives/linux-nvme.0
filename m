Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8EDCEDD98
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 14:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/AzJW0N5KlzFwGk56ZS/QWVVUxZznWUyJSgRHfPVWIs=; b=D38MOgruFE6iuRVhQVBT1GAmMI
	CrvwfDutEqyF6BOqdOTUCCi97Udi1JrShIrNcbJqmyw4Js9f/nSUuS8iCd/2w8htyU1AcJfuGnZUw
	6VKnXOjhatYvkFck4N/RYpP0d/xZMiOsTbR1HznsjoAN9+4CPQy7SJbjuMYzWKFEHlVNkHmfGNEFo
	UFCEb2NsJqgm6lNwYlm3GKlIGlr0iHxxsOxhVluSVFB+0Whbefp/w4GQdQ6SCDWhqk3jHGInAYpDv
	uT0OiSYCQVLnQrOdGlCvsgLIebDsFFXeefYQ1EeABGYc//Q8luyGVhr3BESRBJ4172gdXJ70vsmgo
	DOPzJPpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syXFB-00000009VCL-0D3A;
	Wed, 09 Oct 2024 14:00:49 +0000
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syWEx-00000009JeL-3Los
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 12:56:51 +0000
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C13DE13802E0;
	Wed,  9 Oct 2024 08:56:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 09 Oct 2024 08:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728478589;
	 x=1728564989; bh=/AzJW0N5KlzFwGk56ZS/QWVVUxZznWUyJSgRHfPVWIs=; b=
	lULr2O2iRO1OFbj6r6ObkI0ABNLJjclHuTgiYorMmC9yXQsEe8LQeAeMDiUcOQsb
	r31e5qauOKL8zrg7qs5D4Xk4KmH3UQSeTtXaJ/sUEHAeZg9DFDuNnyzCKN7TYrVV
	PQnj8B5ksdzZUJtvHbGpvVx0h7TrOFYAr/uPTGCffC8mc7KpWf027cGgYFAnPG47
	cO4M5sewayP1WLHtfh9YnuHMt+B4v4dl3M8q4J2ahcNiHWUeVRgjZKXTRTVXZioa
	Jv4ZN6cfTbudRH1VaTQkEZgWjchT9UMQ9fMaM7r+1L05I+cHM1Cq7IBpRPqgDvke
	27AhnctxkEpRwW7pN0CQ4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728478589; x=
	1728564989; bh=/AzJW0N5KlzFwGk56ZS/QWVVUxZznWUyJSgRHfPVWIs=; b=R
	jjuVzkAacpX+gyzYy057yWObbkKF7JTsN8fr4sstvMXl5cJtyMcn5kK74M/3Qre3
	a3hZtul0rdZM04Cjf5ZX/5Do42MQYGzTOhS3aaQVz83bCuL8bXSYdjaQtS5jzhf5
	IfUQ/ARdADkZyzMZs4Ec3tBKsh8HxT6px2a4JR1d1d23All/xp4nNuPudsnzZqSf
	gTq8xq9fD8gXXYgG80QWmQ903Pov46Xsm9JtEYZ5P7dwppUPz0dxcnL6A2uySKDm
	skfZ7DWHB6LiEDjOwWJ2otnb2FMMa7sc19S6IBn1W4pQKyNXZvHzbfA+wDKTHDG8
	BmzioGSWxbXsjHUzOA0+w==
X-ME-Sender: <xms:fX0GZ1llMCZbH9_N2veLB2gplhiLomVR4rtoG1e0jMLZElTbBh8CXw>
    <xme:fX0GZw05q6GyQ2C4mukE0zCXM55Da1mbKve8ielUym5L0dfpTv61OSd-Wqoe8U_XF
    9h5iuWmT8DjXagwpQI>
X-ME-Received: <xmr:fX0GZ7pQhYC9dx2FFvPGUy7xO3dpYehkZDK-lxdSxNjD5quHB4RoflxRFQYxdhY15ZX6py2yGXN7ccYb5xXwkTrM5Kr9Aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeforghtihgrshcuuehjpphrlhhinhhguceomhessghjohhrlhhinhhgrd
    hmvgeqnecuggftrfgrthhtvghrnhepleehjefftdeijedvveeigffhgfdugeduieevudeh
    jeefueffkeegjeffiefgheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhessghjohhrlhhinhhgrdhmvgdpnhgspghrtghpthhtohepkedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopegulhgvmhhorghl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghsshgvlheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmrghtihgrshdrsghjohhrlhhinhhgseifuggtrdgtoh
    hm
X-ME-Proxy: <xmx:fX0GZ1nnpXu1rct-gfyhbSgHB7IZA7ONhaJPKP60XIzMaS7ocQrSjg>
    <xmx:fX0GZz07zWNh69s0gFFlE0a4_s3PYQM-YOevdx_ksqrjzfMkb-edfg>
    <xmx:fX0GZ0ujveQY0oaLlJO5t01xYP4ZQpFmVs43y3gKx6n0nEQ1vVXKFQ>
    <xmx:fX0GZ3V6NcvneDu72cF5w0lTuYN2bIuiRAzr6OQbHmdRGKoAmhzfGw>
    <xmx:fX0GZ8LbcTilPp9YiRHz1t4rN8-BenERTb0jg7wtxVYhgjtEolQvKdMN>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 08:56:28 -0400 (EDT)
Message-ID: <45a1326c-8a36-4f23-b5e6-c89bbefc5005@bjorling.me>
Date: Wed, 9 Oct 2024 14:56:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme: add rotational support
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Matias_Bj=C3=B8rling?=
 <matias.bjorling@wdc.com>
References: <20241008145503.987195-1-m@bjorling.me>
 <ZwVMLIt4iFX9MUjV@kbusch-mbp> <ZwWsZvOrQGQ2UR2P@kbusch-mbp>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <ZwWsZvOrQGQ2UR2P@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_055632_421316_77255A37 
X-CRM114-Status: GOOD (  15.15  )
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

On 09-10-2024 00:04, Keith Busch wrote:
> On Tue, Oct 08, 2024 at 09:13:48AM -0600, Keith Busch wrote:
>> I still hope to see nvmet report this. It would be great to test this
>> with HDD backed nvme-loop target.
> 
> I took the liberty to write one up. Looks like everything is reporting
> as expected.
> 
> ---
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 954d4c0747704..e167c9a2ff995 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -685,6 +685,35 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
>   		   nvmet_zero_sgl(req, 0, sizeof(struct nvme_id_ctrl_nvm)));
>   }
>   
> +static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
> +{
> +	struct nvme_id_ns_cs_indep *id;
> +	u16 status;
> +
> +	status = nvmet_req_find_ns(req);
> +	if (status)
> +		goto out;
> +
> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	id->nstat = NVME_NSTAT_NRDY;
> +	id->anagrpid = req->ns->anagrpid;
> +	id->nmic = NVME_NS_NMIC_SHARED;
> +	if (req->ns->readonly)
> +		id->nsattr |= NVME_NS_ATTR_RO;
> +	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
> +		id->nsfeat |= NVME_NS_ROTATIONAL;
> +
> +	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
> +	kfree(id);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
>   static void nvmet_execute_identify(struct nvmet_req *req)
>   {
>   	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
> @@ -729,6 +758,9 @@ static void nvmet_execute_identify(struct nvmet_req *req)
>   			break;
>   		}
>   		break;
> +	case NVME_ID_CNS_NS_CS_INDEP:
> +		nvmet_execute_id_cs_indep(req);
> +		return;
>   	}
>   
>   	pr_debug("unhandled identify cns %d on qid %d\n",
> --

That was quick! Nice. Would you like me to pack it up in the serie and 
resend?


