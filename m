Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AF0C83F26
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yKVXiFSrRnWYZjHB7PInXkzk5lBOY7fcLObrtGYxkVQ=; b=h2jXhKMCRZdYxi1Dea069eoQSy
	0KWEz9NuAii/LaaTwAxiHHXFU/Lp0aZeNuUApLy5fp0oAcwCHYZ5mHe499mwyvjoKpGqfih7JD+L+
	Zyw8nivvq0tUf8y1hMRxtf/jqJDILG+btmcX+wAGTdUHeUzVH4kxrVtFQ5UqhndDjC5vVXWMkCgjp
	wTcYXrYlM7uowlMG37rZzy4nDl7o8clTuZtzu+7d9CqT03inRx1Xg0lz4QmdOKltkhKvw17TC09sx
	nm5gqpME6WtZ9LmKKEQaqOCLEnVZHSJpQTA3gsqYozP6ThsPU7tbSRUsCL0MgIbbWh7h4mx6cT2mg
	MF4Zs4Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh9VB-00000001wXS-0Q02;
	Wed, 30 Jul 2025 16:18:01 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh9V8-00000001wWT-0kn0
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 16:17:59 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-75001b1bd76so4530030b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 30 Jul 2025 09:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1753892277; x=1754497077; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yKVXiFSrRnWYZjHB7PInXkzk5lBOY7fcLObrtGYxkVQ=;
        b=fZmIeORNm1Rs89TzqEEohcSuSS15l/7kXR3j9L0t85s0nuwAhBIC9IxHkDHH5ekSF9
         jd3BW0YJWb/heqFiAVfwz+/EVBYXthrNMoyxPI8SGRnfSUhblY29lhSK2ECOlTBLhsY4
         qglD0ebX2wIlPw03J/GA68SU2RuOJ5aCddqH525XiNCapeNbxydZ9HMdfGI2oc0+GfDd
         UhwKGiPRLn2uL1Kg/ldPqXjaxTxshx59Oo1UI8rps5bEY3rUOULcjkgYngMdGQ4tJ1Fu
         cl6y1lJ3PcmgGv88Z1G9Bknye3TSWB9x1AC/YCRbGZbhxPiaeR2GozBL+ll1bD6lSxxr
         iI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753892277; x=1754497077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKVXiFSrRnWYZjHB7PInXkzk5lBOY7fcLObrtGYxkVQ=;
        b=a6pxcgWV0b7CZvXLnc2o6QMV70/wwD5rf82rL5xbSSnjU6BTndBQWn3fU9uoo6kNLv
         bLNLSdVl48qGna9fZ65SRStOzVFWqKrVBNJ6V0wfGrmdOkfVRu685cPwNr5pIw/wkDNh
         GfAZBoDlGp/gWdD1E+8l/wEkkkaIB+AJNVeGSpTEVB4pChmqEzwF0lGAQKdRYqZZTYqA
         nXKuqo9TML19DwpWNLEvWX0xSqde/0sK9EEc43B5eKVyLAg8pBlhTNDYtqnhaGJ9rjC3
         E7Kex4b/B2X5szMXQPbyJ22J+YE1Yd8NTw7/LZ8TDqFeWKB1ZqVC5/4ILl6JyjDMjXf6
         Msug==
X-Forwarded-Encrypted: i=1; AJvYcCWuJoouBSowN072nYD2gQYVtDp2jN48rPG4xiOKodLcAb8b0gdBW4BXhpcrNB5JJbrJ5qrh6Cdh+Slk@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+oa1MtYZZZprAV/OOr8Le09sTeIzwpYL67YFjfmSj8rd9Zemm
	907J9oRNliyk+m+RHSlQvTRWPvoq6xXokHiLWmiZxFMcy/AI4lTdRWrPSfQyrTz1nmc=
X-Gm-Gg: ASbGncsrSvFfUI7wJUAseK9S1gA5cW3i1w9Zc9Mb3noh9B29EzOC8BgbqZy201hv++Z
	QMVjE1XfhI1ZWBlFdaDZNynCZkG9LsMBl7wwr9Z0xw6/4+sjlEWZ37OYts1RO57MsEWkpzcA4uB
	R5CYe5U/Sa/cHQ5Lu2CW1OWs4u/r0NHvPkyvlz7huwLyNcX66bAy5Agk+tjTl8MDYz7/0D53YR6
	zXT3GU25K8R4nO8u7SbwDREbzecEXfLMWhiHqs0qAfHNx2RBrhXdq/uf87P7vIHrIs48/iV7iD7
	YNPI7Bg7mAt5p7fl7N7wodnkHsZaofsyhmhx1ItWSq9RPmZCV89V9UKi4nt4j6XVeBpIN6TGz4X
	8E30g4IbjFKcgLfVMHOfDbG22+0N6QoYwr5G55POzoDc=
X-Google-Smtp-Source: AGHT+IH4WzCZIRsxDkQQbV4ooslyAXOnOnnFTkWKpM4k9PgSJygdHWtyWMUs2KYLkQMOoMS8IbvkQg==
X-Received: by 2002:a05:6a00:814:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-76ab2d5248bmr5203340b3a.12.1753892276985;
        Wed, 30 Jul 2025 09:17:56 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id d2e1a72fcca58-7640ad06762sm11101766b3a.80.2025.07.30.09.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:17:56 -0700 (PDT)
Date: Wed, 30 Jul 2025 09:17:55 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Remove unnecessary assignment to ret in
 nvmet_ns_enable()
Message-ID: <20250730161755.GA1177361-mkhalfella@purestorage.com>
References: <20250725230639.2017274-1-mkhalfella@purestorage.com>
 <20250730155335.GB19799@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730155335.GB19799@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_091758_354284_C3F66FE2 
X-CRM114-Status: GOOD (  14.75  )
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

On 2025-07-30 17:53:35 +0200, Christoph Hellwig wrote:
> On Fri, Jul 25, 2025 at 04:06:39PM -0700, Mohamed Khalfella wrote:
> > Commit 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")
> > moved checking maximum number of namespaces in subsystem from
> > nvmet_ns_enable() to nvmet_ns_alloc(). The assignment to ret in
> > nvmet_ns_enable() is no longer needed, remove it.
> 
> This assignment already is gone in the current tree.
> 

Yep, it looks like it has been removed in commit 2e7dd5c1a8ae ("nvmet: remove
redundant assignment of error code in nvmet_ns_enable()").

Thanks,

