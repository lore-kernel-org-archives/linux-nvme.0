Return-Path: <SRS0=Zaot=23=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8108FC32771
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 08:27:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F89215A4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 08:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K26y+Nfx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJIFg7jH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F89215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=EuBzZBNdHXT6U/O0p6JydMXNsDovgcxV2kZ/rfoqRDQ=; b=K26y+NfxJnWkyx2DWmdhIUbvWe
	OEF5rWCJFpRX40zrTK220GF+UTILnQxgv9oFiEz2qwI7UuNz7McHp3A4IdnO9KItilrlBnzbWj0Bg
	FPrdUdp6lYqqyeZ61oQZ8OxC54P+zF9U+Ho2BYBx6fxOsxOwRmHQiCWaArQZMI5pqvioPz7IQXMq0
	nB6M+/B3t6fFmOyXBIt7AjPFTfle1mvAIgZSd7WDbVicdaAk2qbXuTtKXjnlfLhb2CmFufi4YUjS2
	G1iLivNtxBYgXwdhva5+8bUm2JrbeKBCpiEXJCMMGtP3LZ+8rEtP1bffd6reJ1Dcd9fDeoNEbQ3MD
	sR1wSE3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ioNj0-0004kM-UN; Mon, 06 Jan 2020 08:26:58 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ilFcF-00035k-LP
 for linux-nvme@lists.infradead.org; Sat, 28 Dec 2019 17:11:05 +0000
Received: by mail-wm1-x32b.google.com with SMTP id p17so10833456wmb.0
 for <linux-nvme@lists.infradead.org>; Sat, 28 Dec 2019 09:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=keVLdtmDzKfCNZDNLPPmVKGxTZ+gIPJGKTLEvWI5JiU=;
 b=PJIFg7jHv35lTOjpa0g5Kl4ziYnuC7Bzu5++giN5aG8x6Ton9rpK4AnvdaCFuZSfcB
 d98lUXMc+2+CQQoa0osCw+m7bZbqF2GZipwwfIQghJtFQv0lG2fSNc1uDGw+LOQya8nZ
 6EF5tHh6W/ciEQvLLX76voqgSDMWRlT8+rgNjU6hR6EN9s2FeKwaX3KdqWvCeBHBVHug
 WCz3+LeD+2VhtNl8wO8JLTrJ5fWSQn2bJJGnH4ftAFaP2rwYpyCzjEf2NNHsJu/+TKjf
 akKq12ingbKzlanC7QNr6RQa+FDIsSJ1EZvdQkCIj0AOgdB1ljJ4bD+EX3TLLTP/FCZk
 +dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=keVLdtmDzKfCNZDNLPPmVKGxTZ+gIPJGKTLEvWI5JiU=;
 b=M31VMck4YTsR92BP/AvWsJHqO2oSC6cxWcGu83pKbB3Du5xy6ydLtEJnh6R5Omsxpt
 NivgxE3VJ5wI4KfB8ykTuGPri8xe22FJFPkQnng1uIyZGNLd8Mp6UM1/FqSGaw7evhop
 6LqPSqa1UNoXg5+xkD1dkM0ZVhH5V8f0Q0GeDxFuIa73lvdOMdHYw2CsWZgwH7AhX/Us
 wni1dWZk7ocgve7yzPz6aPj8HcbMJaCVKFTR4wKQBXyuweBY/iURCYaR96X3GP0dueta
 C3IrD/A4DYMDe6OrzrGnh8GmBmHbwAZeH+dE/7LFKA8F5KpNuJtGYSYbn4HSnWeEJoAo
 ZlHQ==
X-Gm-Message-State: APjAAAVvN0ZYYvsKjtkhrEH8e9ZvTNv6Zl2byFlp6CDYQqGaN4Y0lv3L
 2bet7q5ScyOGQluJwTKfE1oj10OxwEJCyNSZjBqR7A==
X-Google-Smtp-Source: APXvYqxsFr9cUD0xUHY7evA3k51uNVzDJKmLSt6jVTxElpjCmU3x8nEdUinSU+SdVyv/1ewvq2dEzslvtb0keRzOaWE=
X-Received: by 2002:a1c:740b:: with SMTP id p11mr26590249wmc.78.1577553060550; 
 Sat, 28 Dec 2019 09:11:00 -0800 (PST)
MIME-Version: 1.0
References: <CABnqofwdPfb=RfCDUh6kU2CUV4v0xxVaT--rfQOZMJy6DG3MTQ@mail.gmail.com>
 <89df70cf-0635-7b38-2504-3c594ff0fe75@grimberg.me>
 <CABnqofzJybjHwLhuoC26bt7W05dc3ZjWa9OkmuD1_7-Y7ma3Xg@mail.gmail.com>
In-Reply-To: <CABnqofzJybjHwLhuoC26bt7W05dc3ZjWa9OkmuD1_7-Y7ma3Xg@mail.gmail.com>
From: Sudheendra Sampath <sudheendra.sampath@gmail.com>
Date: Sat, 28 Dec 2019 09:10:27 -0800
Message-ID: <CABnqofxdFukBgmxArP6u03fF7F6TMKuxHNNnm46muc+5wBrcuQ@mail.gmail.com>
Subject: Fwd: Question about nvmetcli (tcp)
To: linux-nvme@lists.infradead.org
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191228_091103_724910_C363F0EF 
X-CRM114-Status: UNSURE (   9.95  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 06 Jan 2020 00:26:57 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

---------- Forwarded message ---------
From: Sudheendra Sampath <sudheendra.sampath@gmail.com>
Date: Thu, Dec 26, 2019 at 5:43 PM
Subject: Re: Question about nvmetcli (tcp)
To: Sagi Grimberg <sagi@grimberg.me>
Cc: <linux-nvme@lists.infradead.org>, <chaitanya.kulkarni@wdc.com>,
<james.p.freyensee@intel.com>


Issue RESOLVED:  I created the soft link in "sysfs" and was able to
connect to the target.


On Fri, Dec 20, 2019, 3:42 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
>
> On 12/20/19 11:38 AM, Sudheendra Sampath wrote:
> > Hi,
> >
> > Apologies for flooding your inbox.  I got your contact information from
> > the linux-nvme mailing list.
> >
> > I am trying to setup a target -> initiator using nvmetcli.  Below is my
> > json file :
> >
> > {
> >    "hosts": [],
> >    "ports": [
> >      {
> >        "addr": {
> >          "adrfam": "ipv4",
> >          "traddr": "192.168.123.32",
> >          "treq": "not specified",
> >          "trsvcid": "4420",
> >          "trtype": "tcp"
> >        },
> >        "portid": 1,
> >        "referrals": [],
> >        "subsystems": []
>
> You are missing the soft link that binds the subsystem to the port.



-- 
Regards

Sudheendra Sampath

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
