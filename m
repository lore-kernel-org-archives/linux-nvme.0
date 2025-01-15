Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFDEC02183
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 06:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UmTK2k4vF2mqctoCssOfytU8KQ/2i1ya8c1dPxSZwZk=; b=Gum2YbqJegtiFg+xfBHYN2IHLp
	/6Db7SOx4uErA92ZtcQqc66PMzngcyKBAyOVUNFMjqsyEI0M+ti5pq4KrQY79iRMgdAvlar+ud8k1
	mumMfhP0xpR0Jo+IKHyHNL14duFix6JnwcY+EHJyceX438OEGx6AWH3k5SFYqwurO6V/9Qn1Zw47z
	cpJQ127D4PNqT0jy3TRsWzZ0qClRcYsl36zD0RcVR24+QwpnE0j96WPkfWUbigrEF0kvREuzdGsWh
	l+RZs1JhduYv9jk4Va41gcjH3Db1FQLzg5yDf6t222UIBhCs5J+VQSpiZi8dYk010wJm6RlrfFx7w
	+6rdAwPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwtP-0000000AmtA-0i01;
	Wed, 15 Jan 2025 06:28:43 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXuHB-0000000AXBt-2cbh
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 03:41:06 +0000
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-e573136107bso7891935276.3
        for <linux-nvme@lists.infradead.org>; Tue, 14 Jan 2025 19:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736912464; x=1737517264; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UmTK2k4vF2mqctoCssOfytU8KQ/2i1ya8c1dPxSZwZk=;
        b=aW3TUH//dDpTq5oFX7X1CfuAuL5b+5/YmC/BYdW81Pe6tflzq/uMiJOt9W5byuyjmC
         66mhl40V0oUU1+wcCpJWFBCPQGTD5MllQtceAKBVTglayLFcZZZib5AAceIRsoYw/qb0
         gAaSpD09Hr7ohPR739n7wZHyRGbdfx1ZKuKHDnLK70Ddj48dzneQRZemwW/ViUDl8YOl
         I5lKgPhBSbOS5bGsAAMtpFGzJGsL+9IU/aFffFXTPDQYnHr9XjVTvZIFeOku8xvNKdB4
         t5hnr+v3c0uEKz8Td3vKjTXv164tvLf/GOklTg1R8DhG72j1Dag3F+wHQo03HPybApGB
         PIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736912464; x=1737517264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmTK2k4vF2mqctoCssOfytU8KQ/2i1ya8c1dPxSZwZk=;
        b=us41td9XXT02i66Pf7wGA9BJzFzzC/nFa2ytFp4SAJLhpc0R2lAkV04KcOkRNVE8j5
         zdhX22DnAEloE8S6tF4YuRj0NbuatWiPIz79kK4i0CvxM4PzG1vjLcGXjuhMMGxmb36+
         I1TNc9M0vmgBhTX5Qt3diS8GfS2TIMrXBu+FXft4+lTZqdwyBSd1mTQTnVI2gjfttghC
         v0gJKE2B4J65hN9DDiD/r4F6cjN+wAxIFLdgivCjXIfqt71p3/HvNC2SJIP/wkCEpPdz
         y/TixWnEyQuJBz6mGdYYNUlqGeSyayMai2yJFWybmW3JlxUTGqgDc/pc301MgVOY5O5u
         DK0g==
X-Forwarded-Encrypted: i=1; AJvYcCWupxqNftuzM4yv7uVe4/YkGjxdYAGc30wF/DR8G5loaxCfClUZLw5o1//1ZQjRD6kZZwfEbnqQchNg@lists.infradead.org
X-Gm-Message-State: AOJu0YxzlrnrT506QYqv7G9jal0fZbMPBz/1WRhdd50kLd8xiVGQg/i9
	m5WSL11oOBlEPhBmLB0mPGRwUdCpWzPmpFY18PPosbl42MGQJAcf
X-Gm-Gg: ASbGnct0oUG1FHkaMBjGh3tOyVMYFg1FhAewzzDBQglgfMDMbxlpC3nxjRCV84G/1nH
	cA5QHQkcP91Nc1m4Gj95j9mOcBNjU5Lda7PWCY8j8d+vY7zMK8Vscg0HGPTcg4vfzsB8aEKyfZm
	75WfueiNOiRArZ1pTSUURxK3+KOUK+rtsdTL0kO2RJzJL/ZpIePV4eSUAdOe0TCar5uJ41nUPkK
	y+fApvPtgXvPLV14a1P2g18Azkdkolea3io4RxHVMPT5FDVGziwaOYV
X-Google-Smtp-Source: AGHT+IGlCnPNZfANCVJooif/vwR9Wcfdn14fNs9Squ/CXSzhwHBTvNfC1cp1ga3/es5eAiOB92QKfQ==
X-Received: by 2002:a05:690c:45c9:b0:6f6:cad6:6b5a with SMTP id 00721157ae682-6f6cad66c84mr8171767b3.13.1736912464441;
        Tue, 14 Jan 2025 19:41:04 -0800 (PST)
Received: from localhost ([2601:347:100:5ea0:e12f:d330:c8d6:a6b7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6c93732c9sm1796417b3.103.2025.01.14.19.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:41:03 -0800 (PST)
Date: Tue, 14 Jan 2025 22:41:02 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kurz <groug@kaod.org>, Peter Xu <peterx@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH 06/14] cpumask: re-introduce cpumask_next{,_and}_wrap()
Message-ID: <Z4cuTsHbO6yiuFKA@thinkpad>
References: <20241228184949.31582-7-yury.norov@gmail.com>
 <20250103174432.GA4182129@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103174432.GA4182129@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_194105_661776_FAA2499C 
X-CRM114-Status: GOOD (  16.59  )
X-Mailman-Approved-At: Tue, 14 Jan 2025 22:28:41 -0800
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

On Fri, Jan 03, 2025 at 11:44:32AM -0600, Bjorn Helgaas wrote:
> On Sat, Dec 28, 2024 at 10:49:38AM -0800, Yury Norov wrote:
> > cpumask_next_wrap_old() has two additional parameters, comparing to it's
> > analogue in linux/find.h find_next_bit_wrap(). The reason for that is
> > historical.
> 
> s/it's/its/
> 
> Personally I think cscope/tags/git grep make "find_next_bit_wrap()"
> enough even without mentioning "linux/find.h".
> 
> > + * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
> > + *			   @n and wrapping around, if needed
> > + * @n: the cpu prior to the place to search (i.e. return will be > @n)
> 
> Is the return really > @n if it wraps?

No, this is a copy-paste error. Will fix in v2.

Thanks,
Yury

