Return-Path: <SRS0=c63/=5G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903ACC4332B
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2020 02:34:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4585020753
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2020 02:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XW/k4tYf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H60RQnZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4585020753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date
	:Message-ID:From:References:To:Subject:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fgc5yLePRw+aZY8IMsdjRNFacuiSf45y26VhIzsP1r8=; b=XW/k4tYfjSfrGM
	5j0fhGr+Is0KLk3ByTJVPaYJQCTws6Rpc7qhc/Xbh3Sd8QxWxp/uAURKwTDnIgoC+whdSeywP7nJ8
	IRbPAcMGyCo8U/5YcydL98Ro3O8WaFU0glH4Kder8Nm0cpRiMVv7sTRmKD5vxoNr2u1A9x3bY1oQq
	dl9Y0C4d0+bjraoThCYdNQPTwvrLw9Hm1nJnAZpmK40tbZJWDWLeEpQf8GXQ8hkMtwDW8iGejvuUA
	+n0hLUc6bKau3ebCHPFi6Yc/Mo0lPGycbXRZ/gK415smp0OSsbaoFZHni4885Zi5MR2LqRsYofkBS
	O1PN2Whu5h+Xa38dHokw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFTyN-0005EO-Bn; Sat, 21 Mar 2020 02:34:51 +0000
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFTyK-0005Dx-5M
 for linux-nvme@lists.infradead.org; Sat, 21 Mar 2020 02:34:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584758086;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VnlIalUpjuvJ7w79v3lFc51FFVyPgI4bc8UTEY54Ebk=;
 b=H60RQnZiu8gll0+vB5b/QHVc1KQuzcE7ACrCNkUoPFow5kcA6aH+4cnpWWVqy5jToBT/gB
 XUYQXIqJljTPBfvmWx/psaC8+NIxiD8Qk3T5Jabq7ZzVJYBaWCkR0x0bqt7Iyp/05YOVrm
 7k+bSdfLCpECu3Um16xmIr8rdnIDq5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-nKnx8tSWMuKxG8xatsvkJQ-1; Fri, 20 Mar 2020 22:34:41 -0400
X-MC-Unique: nKnx8tSWMuKxG8xatsvkJQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4B58DB20
 for <linux-nvme@lists.infradead.org>; Sat, 21 Mar 2020 02:34:40 +0000 (UTC)
Received: from [10.3.128.7] (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72FC019756
 for <linux-nvme@lists.infradead.org>; Sat, 21 Mar 2020 02:34:40 +0000 (UTC)
Subject: Re: [PATCH 6/6] test_nvmet.py: Use string.ascii_lowercase
To: linux-nvme@lists.infradead.org
References: <20200320203946.37338-1-tasleson@redhat.com>
 <20200320203946.37338-7-tasleson@redhat.com>
 <BYAPR04MB4965153A921BBBBE14A2636286F20@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <ac0fcffc-ed25-28d5-413e-8a5a9bd46b91@redhat.com>
Date: Fri, 20 Mar 2020 21:34:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965153A921BBBBE14A2636286F20@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_193448_398502_61AFF92C 
X-CRM114-Status: GOOD (  10.97  )
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

On 3/20/20 8:12 PM, Chaitanya Kulkarni wrote:
> On 03/20/2020 01:42 PM, Tony Asleson wrote:
>> This exists for both py2 & py3.
>>
>> Signed-off-by: Tony Asleson<tasleson@redhat.com>
> 
> Can commit message be more descriptive here ?

Sure, how about


test_nvmet.py: test_invalid_input fails on python 3

When you run attempt to run 'make test' on a system using python 3 the
unit test test_invalid_input fails with:

Traceback (most recent call last):
  File "/someuser/projects/nvmetcli/nvmet/test_nvmet.py", line 395, in
test_invalid_input
    for i in range(l))
  File "/someuser/projects/nvmetcli/nvmet/test_nvmet.py", line 395, in
<genexpr>
    for i in range(l))
AttributeError: module 'string' has no attribute 'lowercase'

Python 3 does not have 'string.lowercase' ref.
https://docs.python.org/3/library/string.html

Both python 2 and python 3 have "string.ascii_lowercase".  Use it
instead so that the code works for both python 2 and python 3.

ref. https://docs.python.org/2/library/string.html


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
