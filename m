Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C0AC43331
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 21:55:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6EB2071A
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 21:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HBcL08Fa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IojAl79c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6EB2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date
	:Message-ID:References:To:Subject:From:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VjCrUqb3mvJ08C3nITQVNWntJlMQsUuqmj6lVxPcyxs=; b=HBcL08FanIvg/8
	P5/ABGsP2JNjnn0QO7BRFr6TJuoiz5ddkfS1z15EcJU/LDGv8UIE1y3+68azx/uOdr5J1eJm7cnSQ
	/ZaW8zrir1234fSNeBRmKYegN5Jik+sLUJGX3JAKOOvMRqsgpBX5w1M5izRU1+uP5J+5p9vigc5eP
	KFd2Kh//1dW4WRAz8JPjNlVpmvdV0e6SRBtZvquIZ57OVVq/ao5Bk+2ABE49KLHOypg+KrSau0wlh
	Ho54hpwL+yCW1nHo7TodDODwXJaxd2Xm02J44QS8zMJwG+EZlHWfth8JDPWNJ3AaajOqN/H5TMFhb
	ei9jvQWDfKi4Ps5vlw0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJlKB-0005In-LR; Wed, 01 Apr 2020 21:55:03 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJlK7-0004ss-Fz
 for linux-nvme@lists.infradead.org; Wed, 01 Apr 2020 21:55:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585778097;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kh6N1HXAkc3dTaFlPBWbvLqbGjSSbT2M9aBvOKbg4LU=;
 b=IojAl79ciiyMdOXsBsNHX5oeyHalAClDgI8RxA9S74vgfypeoYlDhMWDKCzjz/AxrZ3CCJ
 7JKNQ1glBLPpCI/wviZ6OhWlnd7aZWpASp/DacuauqQwa8DOLw8oJY8QhQ41wW1bsX9b1I
 aTOZ+egt/7w0YCpCpF4cLb3f/qnguLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-L6yKbR0iPT66hZZDeZC6Dw-1; Wed, 01 Apr 2020 17:54:56 -0400
X-MC-Unique: L6yKbR0iPT66hZZDeZC6Dw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6707713F6;
 Wed,  1 Apr 2020 21:54:55 +0000 (UTC)
Received: from [10.3.128.6] (unknown [10.3.128.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E42D5C1B0;
 Wed,  1 Apr 2020 21:54:53 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
Subject: Re: nvmet: Kernel oops during nvmetcli 'make test'
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <bce98bfa-5740-d184-ac47-6ff1c1c97b30@redhat.com>
 <BYAPR04MB496520CAF145C79746B85B9E86C90@BYAPR04MB4965.namprd04.prod.outlook.com>
Organization: Red Hat
Message-ID: <09a1b45a-8eda-bc0d-366e-33951ae0bdb7@redhat.com>
Date: Wed, 1 Apr 2020 16:54:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496520CAF145C79746B85B9E86C90@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_145459_748484_4A7B47B3 
X-CRM114-Status: GOOD (  14.65  )
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
Reply-To: tasleson@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/1/20 4:06 PM, Chaitanya Kulkarni wrote:
>>
>> (gdb) l *(nvmet_referral_release+0x14)
>> 0x32e4 is in nvmet_referral_release (drivers/nvme/target/configfs.c:978).
>>
>> 973 static void nvmet_referral_release(struct config_item *item)
>> 974 {
>> 975         struct nvmet_port *parent =
>> to_nvmet_port(item->ci_parent->ci_parent);
>> 976         struct nvmet_port *port = to_nvmet_port(item);
>> 977
>> 978         nvmet_referral_disable(parent, port);
>> 979         kfree(port);
>> 980 }
>>
>>
>> Thanks!
>> -Tony
>>
> 
> Seems like referral release has a problem or the testcase related to it 
> which should be test_referral() 353 or 356, do you see any other
> errors related to the configuration in the dmesg ?

Well we get other messages and some errors, but not sure it's helpful?

nvmet: can't create discovery subsystem through configfs
nvmet: transport type 0 not supported
nvmet: Cannot modify address while enabled
nvmet: Disable the address before modifying
nvmet: Cannot modify address while enabled
nvmet: Disable the address before modifying
nvmet: Cannot modify address while enabled
nvmet: Disable the address before modifying
nvmet: Cannot modify address while enabled
nvmet: Disable the address before modifying
nvmet: Cannot modify address while enabled
nvmet: Disable the address before modifying
nvmet: Cannot modify address while enabled
nvmet: Disable the address before modifying
nvmet: Cannot modify address while enabled
nvmet: Disable the address before modifying
nvmet: Cannot modify address while enabled
nvmet: Disable the address before modifying
nvmet: Cannot modify address while enabled
nvmet: Disable the address before modifying
nvmet: Cannot modify address while enabled
nvmet: Disable the address before modifying
nvmet: adding nsid 3 to subsystem testnqn
nvmet: adding nsid 2 to subsystem testnqn
nvmet: adding nsid 1 to subsystem testnqn
nvmet: adding nsid 4 to subsystem testnqn
nvmet: adding nsid 1 to subsystem testnqn
nvmet: failed to open block device (null): (-22)
nvmet: failed to open block device (null): (-22)
nvmet: failed to open block device /dev/ram0: (-2)
nvmet: failed to open block device /dev/ram0: (-2)
nvmet: adding nsid 1 to subsystem testnqn
nvmet: adding nsid 2 to subsystem testnqn
BUG: kernel NULL pointer dereference, address: 0000000000000030
...


> On the other note logging for these testcases could be much better.
> (totally unrelated to this)

Or we could break the unit tests into much smaller units so that when
you run with '-v' you could identify which specific part of the existing
unit test is causing crash instead of just knowing 'test_referral'?

Regardless, I added some debug.  We are hitting the issue on line 353.

-Tony


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
