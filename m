Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EE2C3DA63
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 17:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SwBWPNoui3R4Zr1EZ/J1lj72GU7q4MuqGU4olQnV55Y=; b=x74XGgaqcrIUXJ8zOIjyIOwt/k
	FCY36WKZDrh1lvskItxjeLXOxhrIJ1FNR7u+t8oBTu5PgOFUaUPQLXj8zgvV2ChQEKQSWErcqxVgg
	DxOPDNsmOMw6nrWI7DI/+HaybWdcsbGi2nOi86hw59dqPpGVpt2AUw/Dk9Hqm+qi+4RBN5kFNPks3
	wPv29kV5wq104mp7/GzmJ/rVyntSru6skIaOooEKmcAqPwZl+tVpIdMyfk/fRkmEhKFGBl305mcWw
	r6um2BDaIOE8Tziumw0lYsDz9rKwrhy/PTgR5aUSmqlDehlTYpZltglvwkfDSfwIQu6zewBdi5pbp
	QZUm0BPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWJL5-0000000D7uw-22yJ;
	Tue, 23 Jul 2024 17:30:15 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWJKz-0000000D7tq-380g
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 17:30:14 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE8B11FBF8;
	Tue, 23 Jul 2024 17:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721755808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwBWPNoui3R4Zr1EZ/J1lj72GU7q4MuqGU4olQnV55Y=;
	b=JiAgOgw7wMw84CokkkUwVrahK4jTEXPZBS46frOSbCxDx+TU465Py37fbJI49Zc/FrJnfO
	Wf0ziBJWc1c8lf/Uzp4TL5oefs/lkmWMrsq/C1S5j9tWUF5U44KcWaSBwDAYFOg5Q3396V
	7gVcpatpkAFzfpnSoPXFAt8Dp6LHg9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721755808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwBWPNoui3R4Zr1EZ/J1lj72GU7q4MuqGU4olQnV55Y=;
	b=H8gMZz5TO50jSDObYf/0tubYuPPPMcwRQuZW5z2TshyIZJOVQVOC0uIRBFhbtxJv6ZViR8
	Jg+u4i8eP7JbfGAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721755785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwBWPNoui3R4Zr1EZ/J1lj72GU7q4MuqGU4olQnV55Y=;
	b=gnpAWScG5kedY7qUObMq9+A95QubhI7X3eZAK5lLgmHB4XT0nMawBTC8NBFuyo8aSoXwua
	/TSyuHLraiTqAcboQpWK+dqSYQ9wuNxCRvJKt6y9koU6VSnUwNUq5UZjYmxptCUpx1tdc9
	NYLkgrjVONoF6JVPZEtVpwlH9v7JC90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721755785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwBWPNoui3R4Zr1EZ/J1lj72GU7q4MuqGU4olQnV55Y=;
	b=7YiwXCc2aLxYFzKFcv/UfwyzjVucgAkGO7Rk7vlKLTGqieHmZCOsNruKUT/Bq+u0WH72Bf
	I/MrVcsOvrcHb9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C52671377F;
	Tue, 23 Jul 2024 17:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RIxRLvbnn2bzCwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 23 Jul 2024 17:27:18 +0000
Message-ID: <210a37b2-cc26-43ee-99f3-19dee796e677@suse.de>
Date: Tue, 23 Jul 2024 19:29:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] nvme: split off TLS sysfs attributes into a separate
 group
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240722120226.88737-1-hare@kernel.org>
 <20240722120226.88737-6-hare@kernel.org> <20240723144905.GC20994@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240723144905.GC20994@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.09 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240723_103009_962971_A4673E91 
X-CRM114-Status: GOOD (  19.39  )
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

On 7/23/24 16:49, Christoph Hellwig wrote:
> On Mon, Jul 22, 2024 at 02:02:22PM +0200, Hannes Reinecke wrote:
>> +static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
>> +		struct attribute *a, int n)
>> +{
>> +	struct device *dev = container_of(kobj, struct device, kobj);
>> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> +
>> +	if (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp"))
>> +		return 0;
>> +
>> +	if (a == &dev_attr_tls_key.attr &&
>> +	    !ctrl->opts->tls)
> 
> As-is there is only a single attribute and you don't need the check for
> the specific attribute.  And the point of making this a separate
> group is that we'll want to not have that check in the future as well,
> right?
> 
Correct. It'll be filled out with the next two patches.

> I would have also kinda expected that this attribute group lives in
> tcp.c, is there a good reason to keep it in the core code?
> 
I knew this argument would be coming.
Thing is: these options depend on CONFIG_NVME_TCP_TLS, so
they will always be encapsulated in some #ifdef, be it in sysfs.c
or in tcp.c.

And as we always will have to have an #ifdef in one of the files
I thought it easier to keep it in sysfs.c, and save us having to
have an exported attribute_group which might even be empty.

But if you insist ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


