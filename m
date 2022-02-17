Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE16CC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 11:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QZ38HAApNtfXt6qxNO0gR847n+kwy45+iukCRSyI4Bo=; b=MOyQgAAU/FZ/IMVW1H7mtP5m8s
	w/q+tzqa5yFmielaM7AjdS12xjDcugAuuTdSX3xjmNXNTB9Hu08YUjidy3op4ijesI61g29qxL0vh
	3PQ/yGoMq7rUsA60yOT1+RCevTqm7XpCZvdciFXj34WfRmCoLUSRNdG5nqttxvAwMBYGSiCJeByYI
	z4P5zm0bhvsmn6m4DYAcYy1a+voUL4TCsnHYiDFfV8BBhAn1VN/keXCouIaNRky75gwSXg8teHV7O
	6OyS3C96Tq8tntlWsWbw70XWZobRm9dR0mhQcIaBF81ReZiasZ+LN2tikoY/yYEnoiAqtOMFfH//A
	2IivhfNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKeiC-00A2oZ-VZ; Thu, 17 Feb 2022 11:12:37 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKeiA-00A2lz-EH
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 11:12:36 +0000
Received: by mail-pg1-x52c.google.com with SMTP id z4so4679800pgh.12
 for <linux-nvme@lists.infradead.org>; Thu, 17 Feb 2022 03:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QZ38HAApNtfXt6qxNO0gR847n+kwy45+iukCRSyI4Bo=;
 b=a0rrsLkIArRFfnCMQag41TBZWOqbFfIEuxS44Q5+Zq1gJrmlno78P7AGRojsvflGkB
 K+tAOqwoXvvIqoN5ETu16dk3t5xLwhV+Fjw0G68AVHAynRSi+aMwg0JrydW8a6V15yqg
 spTCEdTf+LawyjWnuKwyJSLXdc7jbEEXwjxX2sKwFxWoPmmlYcfhwm3aVDnwEJtmPAbz
 TwGCoXcLzDg810/J+T2oUEG2NI15p1mEkc3sYSCx+gJVRj/X4zEvG6vg49BswQbArzv1
 p+XHRkCK0VKVFiloLtwthO/I1fihve57D061GPu2K/gX1Gy34RE55aU94WWz/RiAp/ti
 pWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QZ38HAApNtfXt6qxNO0gR847n+kwy45+iukCRSyI4Bo=;
 b=rBqjxVgqVPM3b6Vaa+01eWxhh9IUfQC9yZxKiglGvSbfSMDe3b6mp0gaqsayqgT6Mn
 xG1LwH1n2TpJF9AU+mJB6cBCjZc6rUbQMp4FvzCDfguo2GWthCwGxZd8a3SHF77UPUeC
 +Ni5drrGqNuqzGHtwlFbhbdM+3yRkK0mq+yCLy6/KRpXIEnqmgKz9Pn94MCFJAC7TnN2
 6XfoQT72f5CsNUqwCm/IVyKvq5cRL2P0+co1DDZT1o9whZgXxA9KiBwtC7keZ/FeovvQ
 iDb1uMhOSPD9gAKUqbGvBE74EHTWzfbBlmlLhVrE6BD/hdfJVbUCimkgxSjjXvUbskQF
 iCBQ==
X-Gm-Message-State: AOAM531hHwLFL7z6eWXtxvMuqwmE9gqeocrlTUWMSVp8vembW5pbEW7y
 7mGzHKANl6wFIZCy2err/SLBM/FYTYvaKWtjEj9ypi7G
X-Google-Smtp-Source: ABdhPJyfLPxQmoRK++qw23QmLlhzscG5sfsT2bkRAalhl2d06WTqBO3sCC1hOIbaJsEZpWNaQ4w2CbCay5t2YQZUvuE=
X-Received: by 2002:a63:d153:0:b0:343:e405:9401 with SMTP id
 c19-20020a63d153000000b00343e4059401mr1985284pgj.486.1645096353250; Thu, 17
 Feb 2022 03:12:33 -0800 (PST)
MIME-Version: 1.0
References: <Yg0QPv8nH+TusRe9@infradead.org>
In-Reply-To: <Yg0QPv8nH+TusRe9@infradead.org>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 17 Feb 2022 16:42:08 +0530
Message-ID: <CA+1E3r+98wk4MiaVwtOVHKVfR4chFTiA7soD+wPJ1HFmVGXgXA@mail.gmail.com>
Subject: Re: NVMe K/V value devices
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220217_031234_510392_2C4DE612 
X-CRM114-Status: GOOD (  12.37  )
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

On Wed, Feb 16, 2022 at 8:31 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> Does anyone on this list have access to NVMe Key Value command set
> devices?  Those would be a good test bed to check support for the
> I/O Command Set Independent Identify Namespace data structure which
> would allow us to support the passthrough device nodes for arbitrary
> command sets.

I do not have it handy, but I think at this moment there is nothing in
the nvme-driver that limits block-interface for KV. Are you thinking
of restricting char/passthrough only access?


--

