Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07353C44536
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jan 2026 03:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=31l0nbGeLTjwpa82UsNxbLyFca7m2KDZY12SuZ1x9N8=; b=nuPjwRA1gDRzrYZWS0SJhzASOq
	LR1hFCnInCewnLga4S1nAq52qxUJ7tR6Vikshg0EpcLDPe+Pu1J3aRRk1nuIH10P98n6yi/w1dc5I
	R00PL/Mm7JziqbH9Z4gru9dJoiWWOSS/h33lX6jAaQoXiLsNdOKLOIGNLME3WafnWNU+6IivZ1JjN
	JMG9yReI9E41atVlDj/xe0m9kjRYJ0EC7RDC1ecGXUbrfLa/wZa3qa8rAt7oYm3kEqOZo3ZsE58jq
	Qdb1yXYpVpJdePV6cAaasDJszafRz13Mtow/KsPJY6bxa0tZYkqTwd35AB+Q8KZ/cyGquj5T5lx9B
	DpmizC2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vilFT-00000006MYL-2gYF;
	Thu, 22 Jan 2026 03:20:43 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vilFM-00000006MXc-2onV
	for linux-nvme@lists.infradead.org;
	Thu, 22 Jan 2026 03:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=31l0nbGeLTjwpa82UsNxbLyFca7m2KDZY12SuZ1x9N8=; b=udfspR+g3unw93P3GndOy/qnL+
	k89TymW4jwCHYhiqN728xO1cj+Qp8izMTkfS1yJVokH3w6HtzXU9htJvTSZl2zKlVyLSvpH2+OElV
	KbgaY2MIY3P/rrSOipJbiAsgH05sCTLpEO7gv3OQUGTaswVXIkLizD4SSRGpNJlPh96eEfQEaenBD
	xe1iRDWBDMsI0A2yv1eQ2FqN94DWw8HIEHtRpFakIjsJNKDOMwSi3C4SeyVvOoYOly7DHiGvKuOeY
	nAnW6Owv5mjA6ly8KU1MMZ9TgfbSB5j235CCeD0BxPhPP/IEg9+eF2WdcBvG6pjXFYtfI2cTobywD
	HCVx3vfw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vilGr-0000000CsEq-1hPu;
	Thu, 22 Jan 2026 03:22:09 +0000
Date: Thu, 22 Jan 2026 03:22:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
Message-ID: <20260122032209.GE3183987@ZenIV>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260121_192036_727042_7563D8C0 
X-CRM114-Status: GOOD (  10.70  )
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

On Sat, Jan 10, 2026 at 02:24:17PM +0100, Christian Brauner wrote:
> The annual Linux Storage, Filesystem, Memory Management, and BPF
> (LSF/MM/BPF) Summit for 2026 will be held May 4–6, 2026 in Zagreb,
> Croatia.
> 
> LSF/MM/BPF is an invitation-only technical workshop to map out
> improvements to the Linux storage, filesystem, BPF, and memory
> management subsystems that will make their way into the mainline
> kernel within the coming years.
> 
> LSF/MM/BPF 2026 will be a three-day, stand-alone conference with four
> subsystem-specific tracks, cross-track discussions, as well as BoF and
> hacking sessions.

Will there be an option for remote participation this year?

