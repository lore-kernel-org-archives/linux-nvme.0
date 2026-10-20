Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A78606A319
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vbAIfUm/;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=UzBITDnP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dsYw/Tubb2vrl5Whids6Qo0hzPpgh0vmBncw/dPN57E=; b=vbAIfUm/TTDEib/dysohdX14rV
	WqGh8d/WRYjTS7X/y21cumM6vrlvxy8Uwvd1CyV4SHA/LrXRql/1lApmurLx4Sc1UE5OYaFsY7G4f
	j4n/mfzvrajQBZNQG3qO1epcnViOaG3BSxmeeuM0vyvWHPbjI7mFznPAfNiHQu+yiz5WkAzfLKaUN
	2OBV7H4SjLCkqZm16LneNbQnlU92EcIV7gz8qzPtpp2yl3iNtoRdj9aTGLIPvlgo6i9FzW08JBRuz
	XkN7dbAhfiW1SVZq410MV4WxWJ59Fdbj1CJZU69jr/9q2tiHYvCnTIzdO4oytTCSnmQolP7CW799L
	owZ+gVDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJJh0-0000000Apys-39Me;
	Tue, 20 Oct 2026 23:56:30 +0000
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJJgx-0000000ApyV-3IeE
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 23:56:29 +0000
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-36661f953e4so241889eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2026 16:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792540587; x=1793145387; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dsYw/Tubb2vrl5Whids6Qo0hzPpgh0vmBncw/dPN57E=;
        b=UzBITDnP9QGATco1xvJ483RwO3ffPtYLwYwiZh33COdrAJjuhVJ4eAxxtxEjNi/jp7
         r/d8g8nV4s5cH1kJMmm7nzAIruBn4aGueCueGXJYx2UwReI3kL/9+tLJcT+cO5VKoCHD
         Pn266nvYSJdSe20okIV945fUbSbZ46MHUwids4mHu/9rVxBlViDYJblYR/KJ5/i31ifJ
         4/y63WzjfU1PZTso8yVggv7qEKrLwUrdDxFkhWOkusicxj1FSynB7s9cQ7HpN8p++1RO
         VAB8jNkNNpaCJ4K10RwufU/BVyCVEDDHTHG4/zxNVwkQ6T3NKLJdKlLpt4NKyA5c8OQ5
         nzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792540587; x=1793145387;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dsYw/Tubb2vrl5Whids6Qo0hzPpgh0vmBncw/dPN57E=;
        b=qk9SweGkoGQtR7zfFGdIrRHsJmz6WXNqQwB3UY1CEzyyd5NtmVC1B5EefzXu8cBz2t
         q60RclvkYwr8yd/ukama7U1HPHnGQFSlYcz3UPz/QYE/TGBopkkcUpiJmpAj3kPErnFO
         L+CrcG61oOzNFLk60Nr9oYO78jqDmf9IFiF/cbO9l408yPYwrSNE8QaGHgPQj5bmXWXN
         thDnDxyWPhWW4/nLrhyTsoMKZFI9JY6mzKLYmIm98Z47uEBYhVwYoSWSGoBayc5/9NKf
         A7BqK2iAy79AuPO+TAVftXccFBlFoR22EEaVZe+eewea19FHaHW5hRXCYl7Nuf6G0Jnt
         rbjA==
X-Forwarded-Encrypted: i=1; AKwUvBw3gbiEbKm1ArVITxzIl5DCyItdX20IDOfnLyYcqOBLB0juYMIIWmS76u18xp+/pJF/abUBtaEyJlXn@lists.infradead.org
X-Gm-Message-State: AFq9FYKb/bgSJtAee1I+O3HG3480xkxIcDG4XnIxDIfp/RcFsoV6oFxt
	59DVbnUwQGxx7W1hjyGqhe4jNjxnBSU681zttw3J/hRJFfHLO8KKB10PgAb2vZt5pzw=
X-Gm-Gg: AYBFou2lOViXXYUoYgEF1KlrrYTzNhj1qukjPdEuo0XvNghmF2xTXvY6N1z551LB8BV
	gjokDPP1lJmtbZMRTBamGsn2Hv5fG2CtgMLH/qt6lkWZs9a0/+I6OAnRRa1zOUFXADWSAvUUSMh
	+06n/pBukAkbWlMywSwUuu5DvtQ9gg5ez3Q2nDaPmnokrKJ6TeOZfGrmmkMj4t+ur4Yw5uDGWnb
	npxXUcJTtQB8NBH+WFs8kemxwPh64AcasX6MFA/f9cVv/LtxcLDmGXwcjEo6VXYMJicClnwwyPk
	YmURefeHWbOGwfu/+rkrrrIFStw0qQ6WBk8vxkURNwmTNg2iSAmyCHh9mNe18tPANbaL6jJoKMN
	ai1OlhyZpL1RsRoc+XK2ZDVYbMxOvG6Y4EgSv0zDcN/9RTXRQiA9AKNVcwQ3ZGx9kykcAZ/gNDi
	zlFLl/NuvnHQ+ZeRCsy1vsmpC7yYWom7fnUEjNWtwMVw6zi6uHkosZrKLgJnmg8Mfw6mdGP1he7
	Dz3RlufLMlVCLuoBHE=
X-Received: by 2002:a05:693c:620c:b0:35b:fe88:d053 with SMTP id 5a478bee46e88-3674e04d982mr1120371eec.23.1792540586218;
        Tue, 20 Oct 2026 16:56:26 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-367405ee5eesm1775987eec.8.2026.10.20.16.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:56:25 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:56:24 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/18] nvme: Implement cross-controller reset recovery
Message-ID: <20261020235624.GQ2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-9-mkhalfella@purestorage.com>
 <6e0b4de0-b030-47cc-84ce-3f021a5c75b0@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e0b4de0-b030-47cc-84ce-3f021a5c75b0@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_165627_829781_D55686F0 
X-CRM114-Status: GOOD (  19.31  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue 2026-10-20 10:55:10 +0200, Daniel Wagner wrote:
> > +static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl,
> > +			       unsigned long deadline)
> > +{
> > +	struct nvme_ccr_entry ccr = { };
> > +	union nvme_result res = { 0 };
> > +	struct nvme_command c = { };
> > +	unsigned long flags, now, tmo = 0;
> > +	bool completed = false;
> > +	int ret = 0;
> > +	u32 result;
> > +
> > +	init_completion(&ccr.complete);
> > +	ccr.ictrl = ictrl;
> > +
> > +	spin_lock_irqsave(&sctrl->lock, flags);
> > +	list_add_tail(&ccr.list, &sctrl->ccr_list);
> > +	spin_unlock_irqrestore(&sctrl->lock, flags);
> > +
> > +	c.ccr.opcode = nvme_admin_cross_ctrl_reset;
> > +	c.ccr.ciu = ictrl->ciu;
> > +	c.ccr.icid = cpu_to_le16(ictrl->cntlid);
> > +	c.ccr.cirn = cpu_to_le64(ictrl->cirn);
> > +	ret = __nvme_submit_sync_cmd(sctrl->admin_q, &c, &res,
> > +				     NULL, 0, NVME_QID_ANY, 0);
> > +	if (ret) {
> > +		ret = -EIO;
> > +		goto out;
> > +	}
> > +
> > +	result = le32_to_cpu(res.u32);
> > +	if (result & 0x01) /* Immediate Reset Successful */
> > +		goto out;
> > +
> > +	now = jiffies;
> > +	if (time_before(now, deadline))
> > +		tmo = min_t(unsigned long,
> > +			    secs_to_jiffies(ictrl->kato), deadline - now);
> > +
> > +	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> > +		ret = -ETIMEDOUT;
> > +		goto out;
> > +	}
> > +
> > +	completed = true;
> > +
> > +out:
> > +	spin_lock_irqsave(&sctrl->lock, flags);
> > +	list_del(&ccr.list);
> > +	spin_unlock_irqrestore(&sctrl->lock, flags);
> > +	if (completed) {
> > +		if (ccr.ccrs == NVME_CCR_STATUS_SUCCESS)
> > +			return 0;
> > +		return -EREMOTEIO;
> > +	}
> > +	return ret;
> 
> 
> This part could be made a bit simpler and there is no need for the local
> completed variable:
> 
> [...]
>         if (!wait_for_completion_timeout(&ccr.complete, tmo))
>                 ret = -ETIMEDOUT;
> 
> out:
>         spin_lock_irqsave(&sctrl->lock, flags);
>         list_del(&ccr.list);
>         spin_unlock_irqrestore(&sctrl->lock, flags);
> 
>         if (ret || !completion_done(&ccr.complete))
>                 return ret;
>         if (ccr.ccrs == NVME_CCR_STATUS_SUCCESS)
>                 return 0;
>         return -EREMOTEIO;
> }

You are right, this is deleting "completed" local variable at the
expense of checking the ccr.complete again. I find the current code
easier to read and reason about. I prefer to keep it as it is.

