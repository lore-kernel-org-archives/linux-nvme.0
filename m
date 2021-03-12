Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98ADC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 15:38:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919BF64FAD
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 15:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919BF64FAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wBpkdsmsCMaQHIwirHsBq4tXM2UFiG2MhtXGhXwwd0o=; b=nJnNRYEpkdlrN+YHoyEPp/76S
	ZuLTDW5tn5lBPyZzDcF8Xz/DoGc+tXfxpxDbHO7JbXUtV+YtwKCfdDi30OlxFcZohBlFUOfRKk/xM
	iyFoWsv822GeShFXyCBxFEZq7cDzNfzl4CVviNKT5dyJLh5LoCcW+9hMSdL+ns5ULD5fosFvdcCdJ
	CIHQ3QsC00oZHgN4rDfAuyFyNw35pXJU2qnPvZhhZ9hujk4k/mid3cJNd9/TlSIR/Ap9Tzv45WFnp
	d+lG/5oKhPTsFVC/gy3RBmwv6n7yCsVd1I95yNk/XOt28aYspsrpgjLyO94IG690r9gEOuVjCjaiW
	1XRB69ulA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKjs0-00Bp9L-5Z; Fri, 12 Mar 2021 15:38:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKjow-00BoV2-7Z
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 15:35:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615563318;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MPa7/awt4jb3ysTKGRVIL64VuNjuOp4uMYuG5tFGB30=;
 b=Uy4mjn4l8YunpE7QQZCy7C3jPzs7IynN6cR42PeouKqzsrK0RRT3Sx/d3xQHxckETz8bPJ
 ffdiJaXl9DBfw7tqKPp3Ym4J/ms29E51Kk+arWjxOGkUebk/N7rPhdw0/0bPDal9Ak2f0E
 CmBIdpTdpHFTCjXYTlHdJmz2VuZ/yWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-Zzd8FTKzPBCs_Y7_sG8NIA-1; Fri, 12 Mar 2021 10:35:16 -0500
X-MC-Unique: Zzd8FTKzPBCs_Y7_sG8NIA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F6C5100C667;
 Fri, 12 Mar 2021 15:35:15 +0000 (UTC)
Received: from [10.3.112.115] (ovpn-112-115.phx2.redhat.com [10.3.112.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C53425C1C5;
 Fri, 12 Mar 2021 15:35:14 +0000 (UTC)
Subject: Re: libnvme questions
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Keith Busch <kbusch@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Tomas Bzatek <tbzatek@redhat.com>
References: <245fc813-9441-56d8-47e2-4417fc1f87e7@redhat.com>
 <20210310204844.GC3377333@dhcp-10-100-145-180.wdc.com>
 <BYAPR04MB49654A2227C054ACC903E2ED86909@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <7e866844-4848-3ef6-cba2-c704a8db74b9@redhat.com>
Date: Fri, 12 Mar 2021 09:35:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49654A2227C054ACC903E2ED86909@BYAPR04MB4965.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tasleson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_153522_480983_CB8D6F11 
X-CRM114-Status: GOOD (  14.54  )
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
Reply-To: tasleson@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/10/21 10:43 PM, Chaitanya Kulkarni wrote:
> Keith,
> 
> On 3/10/21 12:56, Keith Busch wrote:
>>> 3. Any plans on adding functionality for NVMe management interfaces to
>>> the library, e.g. NVMe Enclosures?
>> Will be happen to incorporate any features that are in-spec.
>>
> 
> Adding MI support is good idea ? I think it will bloat the basic
> functionality.
> 
> Can we consider adding MI plug-in for it ?
> 

IMHO having standards based functionality only in the cli as a plugin
diminishes the value of the library.  If a developer is required to fork
& exec the cli for some functionality, just do it for all.

If the size of libnvme is a concern, MI could be built into a separate
library from the same source tree that leverages the base libnvme
library, to allow selective install & use.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
