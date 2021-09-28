Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09B1C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 23:21:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D54613A8
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 23:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 62D54613A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f6/WarFThHLwXIsjF0GWf+4PmF8pmlMcxj/h2oQTtAw=; b=beStjWdqEXgYBXNg0tapv1mW/l
	1XX/hYe0nrOCVdL1h2ZBiXQ48WDG419X2Q9kKsSA9xU4By7VIgjBkN7shNr2W2/VHUxnz/W/o1f3z
	jw9bRIQKiY0Errcs75THbIxvdU5GxC7veBxdfdbj4Yd+1sEPIdVKt33kIc06xCA1gTwBjB0ys2a2Y
	+24FIw+muPY4isiLLpfhttrwTurTgl2lefFzBjdQJGol0AiRTUzwMSqKd73IXfg8F277upsJu61Mx
	4ZiNU1e62Ui9s8qllpJpOVOBrErt2pWsR21dQAaS3Ks4smBZyMDNxTRylrxCPy+cy8dtIdOmM9hOu
	Wl8Xih7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVMOX-009Ffw-Lk; Tue, 28 Sep 2021 23:20:17 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVLiV-00979w-PN
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 22:36:53 +0000
Received: by mail-ed1-f46.google.com with SMTP id b26so1190103edt.0
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 15:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S1uMPmMDCuhl7hGahrzQNiphiHqo3gb8qEbVNkjuXtg=;
 b=ZBnD4YO1BBUMlTjnNG98nhG4VBpQHLVFugeFuFa5lzWrb3DYlAE1oQdqj9gVPkKTdZ
 Zqw6m2QX5l5b6iwbvDgWoSwoMutP3pbp+CuB9LPZkN9Y2nVDn6tJ+LdXAaXq8lK/F+I9
 UiAKzhOJy/oGabFY5ADuoNK8eY/+rqApRS7hwO0lNSSg8a6E8WK0z3SRf4ubTU4MpUhl
 oCKDXg3FhRwbXmdUZtgGmIAof17yC0E757qBaffHLMxcRzPWJIW3wKazcba+5KYBR+dx
 C52+q+LxFB0Blih9HkB+u1370PrsPEoZ/4tWNScO/NbjK3qgW6yJZ3zLfHJeApk1l5Y9
 lpVg==
X-Gm-Message-State: AOAM530AnMNIikz+FOj9Tnm7pPp/wthdVM3sUUyQK8oBAPDV71dmF/3v
 SF8Tf9fOCw5rotWbejo8Dpg=
X-Google-Smtp-Source: ABdhPJxR9giMtZqLl4BWZfAwyz74U2L8eyMtV4yDnOMe7oeocnJlrlxOCRf8G/qY9JnpOssU8JU7xg==
X-Received: by 2002:a17:906:86c4:: with SMTP id
 j4mr9446475ejy.355.1632868609382; 
 Tue, 28 Sep 2021 15:36:49 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id e22sm254319edu.35.2021.09.28.15.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Sep 2021 15:36:49 -0700 (PDT)
Subject: Re: [PATCH 10/12] nvmet: Implement basic In-Band Authentication
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-11-hare@suse.de>
 <79742bd7-a41c-0abc-e7de-8d222b146d02@grimberg.me>
 <c7739610-6d0b-7740-c339-b35ca5ae34e2@suse.de>
 <a2596777-25b2-f633-4b00-18b1a319c5c2@suse.de>
 <32d8f860-9fdb-606c-62b7-ad89837d8e71@grimberg.me>
 <2ccfb62a-d782-7bb2-4d41-6d1152851a4a@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <24d3ee65-83e7-c958-cd17-eb4351a8349c@grimberg.me>
Date: Wed, 29 Sep 2021 01:36:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2ccfb62a-d782-7bb2-4d41-6d1152851a4a@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_153651_884500_CAF62568 
X-CRM114-Status: GOOD (  18.92  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Actually, having re-read the spec I'm not sure if the second path is
>>> correct.
>>> As per spec only the _host_ can trigger re-authentication. There is no
>>> provision for the controller to trigger re-authentication, and given
>>> that re-auth is a soft-state anyway (ie the current authentication
>>> stays valid until re-auth enters a final state) I _think_ we should be
>>> good with the current implementation, where we can change the
>>> controller keys
>>> via configfs, but they will only become active once the host triggers
>>> re-authentication.
>>
>> Agree, so the proposed addition is good with you?
>>
> Why would we need it?
> I do agree there's a bit missing for removing the old shash_tfm if there
> is a hash-id mismatch, but why would we need to reset the entire
> authentication?

Just need to update the new host dhchap_key from the host at this point
as the host is doing a re-authentication. I agree we don't need a big
hammer but we do need the re-authentication to not access old host
dhchap_key.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
