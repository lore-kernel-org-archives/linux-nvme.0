Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1490109C057
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2026 18:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cCd8yAMvqrPDCDQ4w2+qNCSQcd/tOcYNFgI75BEKc2c=; b=MZVXMBTUl6AkCRsAciHudpX2k3
	FjdoNkF2aIeGok8KlAKhATdW60Ve7dQKsSncNd7YeAu/x9aho07Dz4LHTlnxe3Mh7d7HjXaBrHR2G
	CMkhT/sr4cx/h6gpHo3BlLQe98VtYS/z7KnZ/DBG/RLJgjUuFYp/4NYirOtrHCpp/hgox8fbuA8b8
	PNaUaWNMHugzPyKrrEmy4qW9uNn++HsYYTK8jXV1h5utZWv0iVF3RiKjlj/i4BLgQuSM2r2tAhYkI
	HdyRkHLGurZashurcmSj3aSPWx0r4Cb/sb1ClrjFGuWjUCZZ/5PLulMbidf0djvXUYfkRtoHruqrB
	MJHmBDLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5TKz-000000046kb-0TzP;
	Wed, 25 Mar 2026 18:52:17 +0000
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5TKw-000000046k5-0IbB
	for linux-nvme@lists.infradead.org;
	Wed, 25 Mar 2026 18:52:15 +0000
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-2c156c4a9efso232328eec.1
        for <linux-nvme@lists.infradead.org>; Wed, 25 Mar 2026 11:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774464732; x=1775069532; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cCd8yAMvqrPDCDQ4w2+qNCSQcd/tOcYNFgI75BEKc2c=;
        b=VBGtn3WizDpCAL7LLJebkLTFAU2/EYOXwlBLdKZNeLvVp9AtA7TNZvvnP3RoP0Ldzb
         ZamxpzEJ5aVjupBQC63lAhIp9GqOA2A04Kaauis7lWOcm6AEu1uEcQAGh7WcecgzEZxO
         VyQZF9UkhWh8hRiJ9ObKR+pkJnQBLF2ZK44GXUeFBNgAExMTDUaSojS/uJdWroIwHqJN
         iDzQzbGbm0HVzR3LCLqr+OiJYap15VAcI+48uyXJqst5qTp4xkHaoMk99ltPWjW8IJuJ
         FwU6P2F7FTQUYGPgsokXokxdUJuOzXYTRLKW9Bx3dJVXKbZgxe2hLU1SWcDmjvfbzSgh
         w83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464732; x=1775069532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCd8yAMvqrPDCDQ4w2+qNCSQcd/tOcYNFgI75BEKc2c=;
        b=l1je2OvUDlghDGm2XcZy5KiRy6odt7IVGypPxLJHm+4pSQXAhTbDxKEvkN0AS31D2C
         ljWvBwWHPrzPy4Nw9YUiATLrrFDZjn3rOXTSsFC3QqKOzMZn22XnyCNHx4XQIu3JyfOo
         uNTmH283oAKGEep/Ng7zxZc6CuI5WYlp94HbnX4hqV8H5Z0Iu27U3u5x4KX7YdJ6v2Dl
         KmP2y6/gbA6Wz37x3uuVkiX0ZIBanX3hKl4T9qlMTAROTfExdc2gavjMYWSuCTHaADeR
         OGk1C6ozCXX9cOLWDBpqUPdlUS6L15C9+ttgSJjPK2G0smA3jDh38y8mYR+i2kaQ2SUO
         Qkrw==
X-Forwarded-Encrypted: i=1; AJvYcCVn5eMRFjVAsR35wbAhDSHWaXfXAJoctV59MyC7kf1P0NKkchbVXFuF8UIO4l7cLrPKPQui+3Ee2OE/@lists.infradead.org
X-Gm-Message-State: AOJu0Yzezzm1Q0QBkk4mJggDk+S1KKTLbRilV9wTUrI7j7nf465x1TX8
	lwhx+HhTMY0ELteniv6WxklgH2O7Ndj+2I885p6HCgcS4VAyravX+EPVug/3x9QLVkI=
X-Gm-Gg: ATEYQzy0Uo2lKdelJLqiAK2V5fm9fEeUAE4v30tfRYsyq3pfHrLzytrOct4mJsH0C5f
	BVQS3QYAoc4ODK50hb166JNk1NPkPoG++Dw/VpUMuKzRNg4TTYB8538g+g6xNXDIrKWlbU6E+Zl
	vB04gS9OX01NqJyOAYHIoz33a1T99Fd08Y04DCvtJHA9YdHm+3BuTe4kd+mJUswI/S/OWTkbpSK
	6UHx0WZmm9K3C+2bnxW6GUeW3aNlsQCvot5BL2k75jwTRYVWy6zZoVDLFbjVFG5JmNV47rYlDxY
	KQEC7r2EWkcIQdxggOpwhID/KVxd5OjBZhHWs/yffDuRstZ00aeMuRA+lGizlD/Id0Ck64otS7u
	MBKH5clY0+4bo7WDRET3qsx8LzZ/fU5ZGPCYt/ZjRg4axiw457yeK1JlCN9OyEWEO/C+tUx/ESc
	aNZweyOeJHH3XMbAanJ/1wDNHaePm1
X-Received: by 2002:a05:7300:b505:b0:2ba:a60a:15e6 with SMTP id 5a478bee46e88-2c15d3db165mr2427284eec.16.1774464732357;
        Wed, 25 Mar 2026 11:52:12 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2c16ec277edsm761001eec.3.2026.03.25.11.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:52:11 -0700 (PDT)
Date: Wed, 25 Mar 2026 11:52:10 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/21] nvmet: Implement CCR nvme command
Message-ID: <20260325185210.GC145093-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-4-mkhalfella@purestorage.com>
 <DGPVYCG1UFY8.2RRII8Y14TXZM@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGPVYCG1UFY8.2RRII8Y14TXZM@arkamax.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_115214_139750_0862C100 
X-CRM114-Status: GOOD (  14.92  )
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

On Fri 2026-02-27 17:30:29 +0100, Maurizio Lombardi wrote:
> On Sat Feb 14, 2026 at 5:25 AM CET, Mohamed Khalfella wrote:
> > Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
> > Reset) command is an nvme command issued to source controller by
> > initiator to reset impacted controller. Implement CCR command for linux
> > nvme target.
> >
> > +
> > +	new_ccr = kmalloc(sizeof(*new_ccr), GFP_KERNEL);
> > +	if (!new_ccr) {
> > +		status = NVME_SC_INTERNAL;
> > +		goto out_unlock;
> > +	}
> 
> Nit: kmalloc_obj is now the preferred function for this kind of memory
> allocations, see commit 69050f8d6d075dc01a and 189f164e573e18d
> 
> scripts/checkpatch.pl is supposed to print a warning
> but there must be a problem with the regex and doesn't catch it
> 

Got it. Switched the allocation to use kmalloc_obj().

