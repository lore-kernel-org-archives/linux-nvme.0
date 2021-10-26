Return-Path: <SRS0=3UZ0=PO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69421C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 15:35:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D61A60F9D
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 15:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D61A60F9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z7uODUUiQb06oP+J75Wcn0jV5wrOGJAJM7FEoWx1Sk0=; b=M3ugxMaPFD+ryECkIV8efL5vBj
	9xJiShCTyQm5uiYVe9y3GtvdAREmo9HKQB+pC559bza+l1uj4T6efA9uGv1WWxT6NZvwtC3Fjgg2m
	AqgQ2XAIEmk/mOM+69K4wa8fPuL74VX/zLTeS2tGLgZ8t+sOwlXENGplZ7LjbElKrPOsCGVHdwgP9
	mDwCJDxSJ40X22FsqDakUrrjImELv6j5ztObEko59H+d6/JvfL1UaPmiXwltxJRnzlrwQkB6oYrIF
	a55nrUCQcVjVhtW2DzWbnAyeTIhcPpEryz+ja881KwZc8Dm+2vQCoktXCWEZT8md+8J36FfL2tWhp
	/h26zjJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfOTU-002CAM-Ac; Tue, 26 Oct 2021 15:34:52 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfOTR-002C9a-Rb
 for linux-nvme@lists.infradead.org; Tue, 26 Oct 2021 15:34:51 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 j2-20020a1c2302000000b0032ca9b0a057so2601854wmj.3
 for <linux-nvme@lists.infradead.org>; Tue, 26 Oct 2021 08:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z7uODUUiQb06oP+J75Wcn0jV5wrOGJAJM7FEoWx1Sk0=;
 b=Mh06Zm4464f0HBBtiufCQ0YFmLslaEUo5xMb60XIeeLMKzH9Jaq3iJOsof7oFj2DvV
 LGWKOmZUfkslUhByIfJ/B0IaTCMQe6OzjMPykyQ1eTYxXA2KgX47gKBZtEgikwFEyri3
 DfSsdg+4vQFezLlyrwmumRoqGIhQiJiH+q7Ln4WmqwfUANETQxj9WXWMcsX/uWDoejTz
 nvxSSEt+lYS8T54rx2tVi35jdCgTedno+hSGARs6GsMjUnAXQu0Ba8oqKj7DCnAm53u+
 OsB75CLjyko3+RKwM9UsH6iQh008inF+GX1yFojaAeQWR7hUvqZpAghl8xchBtrT/44z
 d59w==
X-Gm-Message-State: AOAM533Stw/pJb9V8AECpan7vVm20/h6CORCT+j4moMaFlAyugqUIwNs
 PcX3iEVdm7nba9mNMjbExQ4=
X-Google-Smtp-Source: ABdhPJx3Zl+338fEVI9TDi5qVr0vb1oH16xL6hOsWCdNvFBZ2CeMdIJDP/QiK7FPNZklYAcYhkkBgQ==
X-Received: by 2002:a7b:c103:: with SMTP id w3mr24372203wmi.145.1635262484652; 
 Tue, 26 Oct 2021 08:34:44 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id y23sm970512wmi.43.2021.10.26.08.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Oct 2021 08:34:44 -0700 (PDT)
Subject: Re: [PATCH] nvmet_tcp: fix header digest verification
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
References: <20211019113307.31852-1-amit.engel@dell.com>
 <2f46c62b-a8c4-5d48-17c4-ac33dec8a318@grimberg.me>
 <CO1PR19MB4885C691C3B1B15AA139A9E0EEBE9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <4a71a194-c715-a38d-6b3e-560eae714451@grimberg.me>
 <CO1PR19MB48856AA2F52E022418DEA773EE839@CO1PR19MB4885.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f74d1d66-1400-89cf-fb15-782369ad28d2@grimberg.me>
Date: Tue, 26 Oct 2021 18:34:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CO1PR19MB48856AA2F52E022418DEA773EE839@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_083449_926667_BECC320D 
X-CRM114-Status: GOOD (  13.96  )
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


> In nvmet_tcp_try_recv_pdu:
> 1. After kernel_recvmsg, 'queue->offset' is equal to 'sizeof(struct nvme_tcp_hdr)'
> 
> 2. update queue->left = hdr->hlen - queue->offset + hdgst and 'goto recv'
> 
> 3. after recvmsg , the offset is greater than the digest.
> 
> So , In this case offset != hdr->hlen
> 
> This will lead to nvmet_tcp_verify_hdgst to always pass, which

I see, so the patch should modify the call-site to
nvmet_tcp_verify_hdgst to pass in hdr->hlen.

> 
> Thanks
> Amit
> 
> 
> Internal Use - Confidential

You should remove this footer from your emails to the public
mailing list...

