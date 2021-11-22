Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A27C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 10:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s5sXkcUSfBycFJ8tqV59dHZGAckmU1H44JkM+kxZDrY=; b=fBPHg4/mGGtRhBBRivmNIhZpG3
	fXcWAZkFSOtkkwI2CLsb5SLCpp2LPnqtYMd/IoJHfgGxinByd2HtW5CjwbDepbCKwEHymbWQdm1C8
	seaqvwN5nR01AqdSEMyM8HCibW8L4wR+zuC5T6dIx47yXcetLFhMaJaEzrCGorOxxFq3xP03zxM0g
	bct7Ci/nwQzxKB8LFwvJMEDpYtV5BBCSTJZxklfwiU4VWvW2WRoYpBN5WD/sUd4nswlJQuMWx4sOQ
	9ZvlL62N9cZfK5+70K/Gv8Wf4P6wqv0yg2GwZghOgLyGtEWGlKuH/ZdhMHSp5GN8l8dlO35Lvmy7J
	3n3lm8qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp6Aq-00FkjD-Ck; Mon, 22 Nov 2021 10:03:44 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp5pN-00FeRA-IZ
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 09:41:35 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 399871FD26;
 Mon, 22 Nov 2021 09:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637574092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5sXkcUSfBycFJ8tqV59dHZGAckmU1H44JkM+kxZDrY=;
 b=hUxdLOZDIQWa0qBZLGJSChlGqZEWRe+7PydcB1xyxtRkG+nCQO1EsOK0wQ/Kiyepa0kb0M
 jST9OzTtOImVl7tL8Q5gZ2eD4iw/AZ7rU1JnRoGzE5mpktIWSka2Qs/pvvL6PO3Nwzp0fe
 o0xqYtNmy8PYPxcSgyxtUaa4TtKRI0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637574092;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5sXkcUSfBycFJ8tqV59dHZGAckmU1H44JkM+kxZDrY=;
 b=F2T9JQ371p+4FHssOHtmdzv2hLbYAvJTJtsfHUA8F1IjXyiT8HHpCjUhR6CK6oTZyJ4hi5
 U9A/NxyVINGK33BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B9CD13C23;
 Mon, 22 Nov 2021 09:41:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cZUpBsxlm2EXXAAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 22 Nov 2021 09:41:32 +0000
Subject: Re: [PATCH 4/9] nvme/039: simple test for nvmeof-tcp connection
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-5-hare@suse.de>
 <197826e6-273c-6f19-f5cf-44814433976c@grimberg.me>
 <f5e414cd-c60c-442a-01c5-dfb0c1422b17@suse.de>
 <3aac418e-339a-1cc6-8b29-456be0174234@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <934829f2-ebcd-78f1-0636-f2fe8de5bb1a@suse.de>
Date: Mon, 22 Nov 2021 10:41:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <3aac418e-339a-1cc6-8b29-456be0174234@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_014133_802135_8DD44804 
X-CRM114-Status: GOOD (  13.27  )
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

On 11/22/21 10:40 AM, Sagi Grimberg wrote:
> 
>>>> +DESCRIPTION="Create single TCP connection via localhost"
>>>
>>> Why is this test needed?
>>
>> To establish a baseline that I didn't mess up _normal_ connections when
>> adding the authentication stuff.
>> But yeah, I can fold it in with the next test.
> 
> This is something all other tests already do though...

Hmm. Yeah, you are right.
I'll be dropping it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)

