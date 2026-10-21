Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36AC606A31D
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0w7YFxYZ;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=SgwErx0T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZP6s6OklCse3eR+K7bjref4ek+TXJ4xDNtPTRq25Yqs=; b=0w7YFxYZhQg2s/I7HcEjIIc630
	FeKfUNOLbx3K9TUXM7BpauCCgPJlUyIcNOkMNKyf9Lbk300b5XD1QMO04nDEPXraCh92YTnBUm7mA
	4n63k850P8lbigFndcxYQsFA76G3Ocz6Tm6gpObJi17HWH2z+LnEZxPU9rI15tzbddF/sRP27fZms
	NLxq5g4PfTmUqrUrUnG+JQoFYvXFQ5x/MksB49ze0Z+KFoCqT87u9RPw6AyV9LJ5ZCirZnP+9ewjG
	zpDdntYpkbE2GbiNFCXsy6tYsRQY7KX/9IiGVM2M6gM8ptKzqYiUj0jZhd3si7EfZf5ZV94+M0a7K
	c3DEIDlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJax4-0000000Ce61-3UpX;
	Wed, 21 Oct 2026 18:22:14 +0000
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJax3-0000000Ce5Z-04Ej
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 18:22:14 +0000
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-3282db206d3so2371600eec.0
        for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 11:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792606932; x=1793211732; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZP6s6OklCse3eR+K7bjref4ek+TXJ4xDNtPTRq25Yqs=;
        b=SgwErx0TnZGx4DZOvzM55784DUsZOgZFu/twc/intxBvOXAlRiUdBVSB+bAHzuTlma
         FPD+jREMt66DDhV0jkOqkxUovv/7TYLU5/ehwldF059jLudP/uDFsiiVkko6UtcRzBic
         8PYMSir5Oh0xzJenk5nUtEBZ3sQ6DEC6YzU4klYLMfaFeL5UXjYQFe8ARFFC7JAYFYaa
         XnowtnoRG5kJky5sK8Z8CGkFBihyxnkAsYLf9mpzUUq4B3tXfWtRfWF1BUOna2mNCFXp
         bi/GYUQ6D7V5XVKA+rt7iKQ1D+sv8V0Vr54JmKORxHvsBzCl029fSxMoyKjGaUgHwV82
         7sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792606932; x=1793211732;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZP6s6OklCse3eR+K7bjref4ek+TXJ4xDNtPTRq25Yqs=;
        b=lxNhvrmVlHTH8/djvIIl5KRT5sYyEyAT6nmi34dic081f6zktvoZVy1rfp6KHG8Tzc
         DQOq0uwkLr9z9NUwn1fTLVCyIvJqLyX0vmQBAJmQhIFeSOpfkPNJTAspwU5HCRchBj0O
         hMm1SKmotD1m4Iq3hUit8+3mp/gjJSLbdbL7L2f6pnKgon88n/Q8UMV1jGb9S32fV8Uk
         84JdvAN8ompXWBwvyUrZfVoJ31NXRPjFV+Q5pYBCtOLxYsuQTOzTtl2r0EfNIS/vKkRI
         zC6s/VWViKeTp085S8hzCIGmXECY3oQLFLUoeaMomkpdp1+Kbg6H7q7ZNsymhNZxxKiE
         YXTg==
X-Forwarded-Encrypted: i=1; AKwUvBzeGp/ChpgrAfaDt6ezIfse/ZLvkxhl0rOltxJAuT8SoDkVHGheSJToVZLXxcrOcUarTFzhYdQAZZ4j@lists.infradead.org
X-Gm-Message-State: AFq9FYKn+tzVgHeftSkq0zOLQwPxmerV/QybpFsK4rViuSg5ATrenajx
	NjPfBEa4AO2JZqBaNetTIIyZymKTBNXcdMwVYb2pEAhapVP2gDLVGAVHzLSmUc4Qx94=
X-Gm-Gg: AYBFou0vQAXrTMFdFQIIodLQOZPNbvj/tMUrlVhEHcu1Jv9Kq338NBcE/FyP0c/P2RS
	mHnrFOrT6iO2Jxju5i2Q3oubXJ8lT41Vl6kuBf/TKeVfyOWLM1xDI1vhP4eontYMZY2P7DYiwEZ
	zbmJPWB6x6qtkVqRr0VZ2K/K5bb9dc+sNYPQ0XlwnRyrt9OxkPBtFc+/NmDtyTfHXK8O1c2uUP7
	S38FDdl1OQxX2nSqE+22scNrNQxjvsLoU3wvv8oSJgEWbAV4XTPiOWHbTRBa9bOCg5WSjEzjYXO
	DSphpjGnWmtKtLKC/8Wmq5DPBi8nGeR6JNRT56uVKV8bODlw0bBTcwMII8Ko7gXsdNnq1x0b4Dx
	F557zxLd/3CWenLcU7E8iM3nnfeZtRvf/puN2mBB8TslDCp3KDZ8CdlhT2JhYrpvRYDXClj0mHg
	owNfqJdhxoHnJ2oVzqRcf6UYQHoZmJp4xHtQmqR1sfGq175ncZcRbkMu8SBQ8n8Nji88inosGct
	LNuX7T0Cca/LCvYVnwiYLAMhL1iAO6d4LbgWSvnz/dlQ190WDAwS3YJY2TXtmjjqf406uM7OwIl
X-Received: by 2002:a05:7300:72d0:b0:353:5cf0:df09 with SMTP id 5a478bee46e88-3674c93add6mr5779594eec.8.1792606929814;
        Wed, 21 Oct 2026 11:22:09 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-367411b4145sm10549688eec.15.2026.10.21.11.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:22:09 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:22:08 -0700
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
Message-ID: <20261021182208.GW2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-9-mkhalfella@purestorage.com>
 <6e0b4de0-b030-47cc-84ce-3f021a5c75b0@flourine.local>
 <20261020235624.GQ2931-mkhalfella@purestorage.com>
 <5f52d97f-dd27-48b5-8502-1a3b5ccf4d92@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f52d97f-dd27-48b5-8502-1a3b5ccf4d92@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_112213_055891_5B4E848D 
X-CRM114-Status: GOOD (  21.46  )
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

On Wed 2026-10-21 10:29:52 +0200, Daniel Wagner wrote:
> On Tue, Oct 20, 2026 at 04:56:24PM -0700, Mohamed Khalfella wrote:
> > > This part could be made a bit simpler and there is no need for the local
> > > completed variable:
> > > 
> > > [...]
> > >         if (!wait_for_completion_timeout(&ccr.complete, tmo))
> > >                 ret = -ETIMEDOUT;
> > > 
> > > out:
> > >         spin_lock_irqsave(&sctrl->lock, flags);
> > >         list_del(&ccr.list);
> > >         spin_unlock_irqrestore(&sctrl->lock, flags);
> > > 
> > >         if (ret || !completion_done(&ccr.complete))
> > >                 return ret;
> > >         if (ccr.ccrs == NVME_CCR_STATUS_SUCCESS)
> > >                 return 0;
> > >         return -EREMOTEIO;
> > > }
> > 
> > You are right, this is deleting "completed" local variable at the
> > expense of checking the ccr.complete again. I find the current code
> > easier to read and reason about. I prefer to keep it as it is.
> 
> The point is that with the local variable, the reader has to track back
> and work out where it is set. I had to do exactly that while reviewing.
> Putting !completion_done() in the condition makes it self-documenting
> and ties it directly to the wait_for_completion_timeout() above.

I think this is a subjective point. For me seeing completion_done()
after wait_for_completion_timeout() raises the question "Do we not
already know if CCR completed or not? Why are we checking again?"

