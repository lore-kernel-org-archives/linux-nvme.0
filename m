Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30671C76188
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 22:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qCRq1DTHGtVBTQJoDR0JwSt/krJ9xvX8WNwgXlKdvaM=; b=qv6KXrtzPZZRnf9sB1zk9Nnvkz
	lUVqYLOWqumFBzVN4BV5dLxibXOcfXnV0/Du0/2Y65z/nxPPpP1ZsjTYDMOa/1xIZO8kZzA79X8OW
	EUQETPWypWrgJYUX7Q/LOMrqwbNMu6y+cnQ6zAyRa3XVDL0TUJWyi4YFO/J+11njn6w8/wilMHwd+
	JBRnngrDFcDbf9Eh/d1gZOOXsnCk4U+kug1KTIPfy7QNqkSDdEgUxDaEnXpleCDAQIG1bFPpxHg+U
	qFJ/QwphmAHmyRi1a03mNiYCa1EYxXLvWhTG1a4BdtS2HRtHNPn4p1X97lozJ4zVJ+WzrQQ6L/xCJ
	CNMmJJ2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjSmn-00H5nq-04;
	Mon, 03 Apr 2023 22:36:25 +0000
Received: from mail-ed1-f49.google.com ([209.85.208.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjSmk-00H5m7-0H
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 22:36:23 +0000
Received: by mail-ed1-f49.google.com with SMTP id eg48so123189789edb.13
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 15:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680561375; x=1683153375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCRq1DTHGtVBTQJoDR0JwSt/krJ9xvX8WNwgXlKdvaM=;
        b=obS0p3/MgX6wonToEgXqk+mU5ftqVwWje57VUFOqqYNbnI+pwcfRlqY3HWotPXh+Wb
         btLHt3pBV/DJ3S7yEHvoDoZtFTo+3xwNxURyDteCfwNWHXD+VfzkJuyWU+cqjaQnFc2Q
         fW8enEdypMWhIKFMEyPKNkk87brgOVNfn/IC+ooxt2aINl+ZduyiGawlLtDANo4u/00T
         Mv6vY4M6thwpZX/eYddJXQyabKPF3sY3dw1FJXUxxOP0JyYKrUA+hWFvEm4Je+9+Fh04
         KMxYjlW2rzkiA82IHfwryr2j/tLIdICmlzuepz0MWrIxhJov09GaeYyEVydhfzRIn7QD
         QnDQ==
X-Gm-Message-State: AAQBX9fhenoNqs0LIaI99CzYLV72fvKbWqBxI78l4UV22Jl012jOQDh1
	U7g36rZdqXj4yoJwYf5wVwI=
X-Google-Smtp-Source: AKy350Yj9cdwFejMnGHyvP+jrUhICombvO6Omof3QfNzroLlnMkhoWjiDvKAlOXIXOh5flZmEGahag==
X-Received: by 2002:a17:906:c:b0:931:4285:ea16 with SMTP id 12-20020a170906000c00b009314285ea16mr202891eja.7.1680561374628;
        Mon, 03 Apr 2023 15:36:14 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090612cf00b009222a7192b4sm5054386ejb.30.2023.04.03.15.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 15:36:14 -0700 (PDT)
Message-ID: <6b4fb6d0-7090-96cb-c780-87c65c2d71a7@grimberg.me>
Date: Tue, 4 Apr 2023 01:36:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/18] nvme-tcp: fixup send workflow for kTLS
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Boris Pismenny <borisp@nvidia.com>, john.fastabend@gmail.com,
 Paolo Abeni <pabeni@redhat.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-11-hare@suse.de>
 <634385cc-35af-eca0-edcb-1196a95d1dfa@grimberg.me>
 <20230330224920.3a47fec9@kernel.org>
 <7f057726-8777-2fd3-a207-b3cd96076cb9@suse.de>
 <44fe87ba-e873-fa05-d294-d29d5e6dd4b5@grimberg.me>
 <20230403075946.26ad71ee@kernel.org>
 <c7a07e1d-b300-dd1d-1be6-311666387820@grimberg.me>
 <20230403114835.61946198@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230403114835.61946198@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_153622_147601_81352CF5 
X-CRM114-Status: GOOD (  23.27  )
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



On 4/3/23 21:48, Jakub Kicinski wrote:
> On Mon, 3 Apr 2023 18:51:09 +0300 Sagi Grimberg wrote:
>> What I'm assuming that Hannes is tripping on is that tls does
>> not accept when this flag is sent to sock_no_sendpage, which
>> is simply calling sendmsg. TLS will not accept this flag when
>> passed to sendmsg IIUC.
>>
>> Today the rough logic in nvme send path is:
>>
>> 	if (more_coming(queue)) {
>> 		flags = MSG_MORE | MSG_SENDPAGE_NOTLAST;
>> 	} else {
>> 		flags = MSG_EOR;
>> 	}
>>
>> 	if (!sendpage_ok(page)) {
>> 		kernel_sendpage();
>> 	} else {
>> 		sock_no_sendpage();
>> 	}
>>
>> This pattern (note that sock_no_sednpage was added later following bug
>> reports where nvme attempted to sendpage a slab allocated page), is
>> perfectly acceptable with normal sockets, but not with TLS.
>>
>> So there are two options:
>> 1. have tls accept MSG_SENDPAGE_NOTLAST in sendmsg (called from
>>      sock_no_sendpage)
>> 2. Make nvme set MSG_SENDPAGE_NOTLAST only when calling
>>      kernel_sendpage and clear it when calling sock_no_sendpage
>>
>> If you say that MSG_SENDPAGE_NOTLAST must be cleared when calling
>> sock_no_sendpage and it is a bug that it isn't enforced for normal tcp
>> sockets, then we need to change nvme, but I did not find
>> any documentation that indicates it, and right now, normal sockets
>> behave differently than tls sockets (wrt this flag in particular).
>>
>> Hope this clarifies.
> 
> Oh right, it does, the context evaporated from my head over the weekend.
> 
> IMHO it's best if the caller passes the right flags. The semantics of
> MSG_MORE vs NOTLAST are quite murky and had already caused bugs in the
> past :(
> 
> See commit d452d48b9f8b ("tls: prevent oversized sendfile() hangs by
> ignoring MSG_MORE")

Well, that is fine with me. This may change anyways with
the new MSG_SPLICE_PAGES from David.

> Alternatively we could have sock_no_sendpage drop NOTLAST to help
> all protos. But if we consider sendfile behavior as the standard
> simply clearing it isn't right, it should be a:
> 
> 	more = (flags & (MORE | NOTLAST)) == MORE | NOTLAST
> 	flags &= ~(MORE | NOTLAST)
> 	if (more)
> 		flags |= MORE

I don't think this would be the best option. Requiring callers
to clear NOTLAST if not calling sendpages is reasonable, but we
need to have this consistent. And also fix this pattern for the
rest of the kernel socket consumers that use this flag.

