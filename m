Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65A7C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jul 2022 07:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rIlQtepRU+lD9WYDZzcY0LHTxiOJlEF6eutW3PJ7134=; b=POyc4QxwgGS0TRvo6qZ9wZbx/h
	uDX+k8MiXYxm5HjeY2xgUo2rZabDsRF8u4aXNejhRbS2Y6HkmuRS2HnfKS3i6i8slnE5vk0HRjVJn
	c+5AuFX9L+8wUsuyM0ktHDYtFj7pcfv9nHaoAWXiF2s+fFBvSpxYaQlajdEFPVOrBj2vqXlX96CIg
	ptauYhekWapH+4xOWvlO81eU3PSIHzHry9sOBawRUpjWZvXr1UF9QY5HPTQLVHnsM+W4uNCNjXxsn
	3jNYloX7KuJvM80EX7bQiwBFleQeCn1isitPZoI6spL/3gxqrqmHzfrszKzmKU/4s7YAq/CMZwW7Y
	hMxGcoig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGEqI-009IUb-Ga; Tue, 26 Jul 2022 07:18:58 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGEqC-009IPV-5Z
	for linux-nvme@lists.infradead.org; Tue, 26 Jul 2022 07:18:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42BC737187;
	Tue, 26 Jul 2022 07:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658819926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rIlQtepRU+lD9WYDZzcY0LHTxiOJlEF6eutW3PJ7134=;
	b=BixwFBP5bRNgcM4fFBbVrJNtNMvvZ04hVw2Kzf8aTXurzAG4FIVco976BJYnji4x91Osk+
	PdhNGZu9JlyVixZ8fkW6A9MY/Knwcj3Nl7NYzcavoHd5TWb+I3L0IZ5vlY/DQALJZyh0e+
	qmYRdmbDtZw3SCjlPkgWT7zg46yiHiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658819926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rIlQtepRU+lD9WYDZzcY0LHTxiOJlEF6eutW3PJ7134=;
	b=05YxO86jiWCHAIVNRF1kfTZIaZqiCyyNGVva5BpIXZ3skq0IMh3XxH58/yxGTT2b/rixpE
	VYdF9FYOJ54181Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3468213322;
	Tue, 26 Jul 2022 07:18:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id n0PEDFaV32K8ZQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 26 Jul 2022 07:18:46 +0000
Date: Tue, 26 Jul 2022 09:18:45 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: consider also host_iface when checking ip
 options
Message-ID: <20220726071845.i2sq2p3c6e6hoa7h@carbon>
References: <20220722092456.24517-1-dwagner@suse.de>
 <3f0528a5-73d2-3dc5-32fb-0eb73797bf71@huawei.com>
 <20220722094648.i6w3dymag3mfjpuo@carbon>
 <ce2ba75a-3dd6-8530-c868-298bbeb93d67@huawei.com>
 <20220722100932.tyjljbccwv47tg4z@carbon>
 <a37fc589-b47b-61c6-0c36-c3b13e7ce56d@huawei.com>
 <20220725092522.i7lch2p4tn7uj6ii@carbon.lan>
 <37845bb2-c868-938b-8aed-cbc18594b9d6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37845bb2-c868-938b-8aed-cbc18594b9d6@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_001852_372951_D98B932A 
X-CRM114-Status: GOOD (  12.97  )
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

On Tue, Jul 26, 2022 at 10:11:41AM +0800, Chao Leng wrote:
> Checking host_iface is similar to host_tradr, so some suggestions:
> First, move these codes near checking host_traddr.

We have several places where we have the same sequence as above, that is
traddr, trsvcid and then host_iface, e.g. nvme_class_uevent,
nvmf_free_options, nvmf_get_address. So I'd say we should stick to this
and not start introducing a new ordering scheme.

> Second, the checking logic should be the same as that of host_tradr.

What do you mean with this? We compare the host_iface with strcmp. It is
exactly the same thing we do with traddr and trsvcid.

> It might be better to add a helper to implement host port attribute
> checking. Of course, this can be considered as a separate patch.

As far I can tell Christoph is not a big fan of small one-line helpers
especially if there is only one call place. But as you said, that's his
call :)

