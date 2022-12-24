Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C2DC10F1B
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Dec 2022 08:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=guue15adONDR1HJUG4YC/J20DWbhpOjSynNnSKRYwFU=; b=sFL23BgObZ/QnWqn4XjFalx/8M
	50s8ZjtfHZOaa47fwCnISORivsFVSmrltwOAhEP1aGq7ITuxVs/R2eKzZ4+3v+9aOMMOBPrHnPu/B
	70UrblXiHWtTtiWIuNE5cIJcM2qu4odG5jJuVl0X22An0wURV1g+3wv+c0jzVCkGMeAqpMvMGDxAe
	EZOxoOpGdAxpTcbk4QYWuhW7gb/RXpy+LbYfk3GdYOjgMk5hVFIwh2mDvixH2+s2iyzxdgFaqsq3r
	vX2Vb07lgdWrt1Kq+/J2IrQ6om1huEZxuIRuaVxpE3fRYaGzZu/z2DvMwKgzTfpopByFBLkEe0hSA
	U29yXIJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p900p-00GVK9-TU; Sat, 24 Dec 2022 08:36:12 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8zKK-00GBXY-PK
	for linux-nvme@lists.infradead.org; Sat, 24 Dec 2022 07:54:20 +0000
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1p8zK7-0002jH-51; Sat, 24 Dec 2022 08:52:03 +0100
Message-ID: <dedcb972-e934-53c2-f933-c25afa5c65a4@leemhuis.info>
Date: Sat, 24 Dec 2022 08:52:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: 6.2 nvme-pci: something wrong #forregzbot
Content-Language: en-US, de-DE
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1671868336;fe2a6579;
X-HE-SMSGID: 1p8zK7-0002jH-51
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221223_235217_298099_C56D2801 
X-CRM114-Status: GOOD (  10.06  )
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

[Note: this mail contains only information for Linux kernel regression
tracking. Mails like these contain '#forregzbot' in the subject to make
then easy to spot and filter out. The author also tried to remove most
or all individuals from the list of recipients to spare them the hassle.]

On 24.12.22 06:24, Hugh Dickins wrote:
> 
> There's something wrong with the nvme-pci heading for 6.2-rc1:
> no problem booting here on this Lenovo ThinkPad X1 Carbon 5th,
> but under load...> [...]
> Bisection points to your
> 0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
> And that does revert cleanly, giving a kernel which shows no problem.
> [...]

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced 0da7feaa5913
#regzbot title nvme-pci: problems under load
#regzbot ignore-activity
Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.ns.

