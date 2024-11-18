Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AEBD49237
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 15:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jpWW0wL+sNaA+UyC1MeFKSHJq7lChKtySr/6iz69uZA=; b=Ic7iaPOdzi1sGD67M2591vfQuj
	c6XaOilE6v5WI/dA6qIssM7tDFBOiwC7JCbf7JNKEc3u5gu8WnaIlHzljQuU0T/T1ANZ1aLbyHs6m
	ClfRsdqkND6dVZfQFiLksSgqyrYBuQcwuAhtKf9WYytn2KBmw/8aTBdNUbIUAsOCVVI4RUE/fAQvS
	CWVTkA0/kg9fNeuLhaG/2MhHqzl99ySLsinOXnezIjdvNYhG9Vsx1NhJZOI3dIrVp7hiZdooNKiRQ
	+iEvoJ1md2/sqX//BISl0LiXY55QXiBq0P3YUHqZUdDOunkJj+g8kXEUfdFoHqI2zw/kJacckcIIK
	6FAT7vcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD3iz-00000009vrZ-0QTP;
	Mon, 18 Nov 2024 15:31:37 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD3iw-00000009vqm-1goe
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 15:31:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 954EDA40B36;
	Mon, 18 Nov 2024 15:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B448C4CED1;
	Mon, 18 Nov 2024 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731943892;
	bh=U3oDJI9MgwAAmIw67zRjHMKb6thRUau+jvkgKgAKJKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EaeAho2SMtqRsiNCqzKHGyHZXmMcyjXvd1NXFFwbXhGBmY/39wctL61MPBRgdGdhE
	 e3e0cjwk4zOrVL370q0umE237RFPs+g3vmvK871lNIIuPKAyJ8hpzB2HF597HJSpnH
	 1PH9njN3w1ryI2tqcNcUXKbj581FvpW6safM4i/FUscLTrznyLW1ASQ/pPS1PEt+e1
	 SRF2qJr8QwOpJDny6xPT28u+qK8MRX0XJg1fIxRxbN7D1DzZfLfgfqnWZ9DPaLbi3j
	 VlKQoyYCm9k3Ivy8Ih5cyB40KClwIF+eXKAOHV+699Dk4vAqhTR9IIlwm5GlxcPhMv
	 IwjUWsW+ONJcA==
Date: Mon, 18 Nov 2024 08:31:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ewan Milne <emilne@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
	Chris Leech <cleech@redhat.com>,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: Re: CONFIG_NVME_MULTIPATH - Do we need this?
Message-ID: <Zztd0oVp1wYDjFi4@kbusch-mbp>
References: <889e1d2a-1cda-4979-8279-f2f665350376@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <889e1d2a-1cda-4979-8279-f2f665350376@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_073134_503234_58DFC37C 
X-CRM114-Status: GOOD (  11.71  )
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

On Tue, Nov 12, 2024 at 07:23:06PM -0500, John Meneghini wrote:
> Now that RHEL-10 beta has shipped we no longer support anything but native
> nvme multi-pathing and I'd like to do something about the multipath module
> parameter:
> 
> bool multipath = true;
> module_param(multipath, bool, 0444);
> MODULE_PARM_DESC(multipath,
>         "turn on native support for multiple controllers per subsystem");
> 
> I'd like to remove this parameter from nvme_core/multipath.c. The fact is,
> setting nvme_core.multipath=N never worked in anything but RHEL and keeping
> it around only causes confusion.

Not sure the about this being a RHEL specific parameter. I use this for
testing purposes, but I don't use RHEL. Admittedly I haven't needed it
recently, but I have found it useful in the past.

