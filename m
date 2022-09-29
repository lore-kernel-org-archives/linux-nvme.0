Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6194EC04A95
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 02:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AYZxTjlN0ZsAHZ9sUyV6Jqgx20B00qm6aYFu4kZ3l+A=; b=vJ9ZICu0lNECa0pQONL1w+RwT2
	Dw/OnV13KTEW6TAnD0hDZmReIBng2Llc+goovxCfRTnqUfbww4mP31bWssLrkWZ3dwCyLY1MJr8Va
	vwhIJfMYykX/J6ehApYWbuvCi57Tsdwh2t8shLvuKQTptlKvE9u6atXgkXvahYtHLFyU0B/8yQEiE
	nEpYRwEaYPvMAqnjGekaHcTPuOLHPQWKu1WV/rUWbRHcDAhVtmvK+DOueB1S5DgWuESOpyDyhGHiX
	3rupvZfkaMwoCb4y1zhmDvHTdnPFIQY6Z6ljE88cSX+wWffl8ztxNMYxyC9HC4P9W83O5jeg4S4HN
	ghcCFc8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odj41-000wqD-HY; Thu, 29 Sep 2022 02:14:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odj3y-000wmi-K3
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 02:14:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664417645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYZxTjlN0ZsAHZ9sUyV6Jqgx20B00qm6aYFu4kZ3l+A=;
	b=cVTJPGoR6RbfpXOoQrCLJUIqpIss56yMTht5jsYD2THKi/GSFzCvJe3hTmjOW96l6bTQgt
	jwh/ydSkkbSqgqU/+AtdBwtZlNXIu6vD7kiLu0UBVDzMbPzxFr7MomQrUbSscn+ojgpiQ5
	3QA0dy9GgzkWbCZyt4iIh8BuqUur9k0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-UPKTh8PSOamkGE3pIoKIQQ-1; Wed, 28 Sep 2022 22:14:01 -0400
X-MC-Unique: UPKTh8PSOamkGE3pIoKIQQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B4B41C05135;
	Thu, 29 Sep 2022 02:14:01 +0000 (UTC)
Received: from [10.22.8.53] (unknown [10.22.8.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A7FB40C213F;
	Thu, 29 Sep 2022 02:14:00 +0000 (UTC)
Message-ID: <410aeb5c-3045-59ac-3fc8-fe80a89b9119@redhat.com>
Date: Wed, 28 Sep 2022 22:14:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
To: "Knight, Frederick" <Frederick.Knight@netapp.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "hare@suse.de" <hare@suse.de>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
 <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
 <6e172046-53e7-d2cb-38b8-e87d725046de@redhat.com>
 <20220928152616.inzetc3fsvnhb3o5@carbon.lan>
 <DM8PR06MB7704CA28602F1367574EB23CF1549@DM8PR06MB7704.namprd06.prod.outlook.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <DM8PR06MB7704CA28602F1367574EB23CF1549@DM8PR06MB7704.namprd06.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_191410_760701_30CAC257 
X-CRM114-Status: GOOD (  10.64  )
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

On 9/28/22 14:02, Knight, Frederick wrote:
> Reset and Disconnect are different.
> 
> Reset uses registers (and therefore Get Property and Set Property commands) over a valid connection.
> 
> Disconnect causes a reset (you have to reconnect to the reset controller)
> Reset does not cause an immediate disconnect.

OK, so you are saying that the rule "The controller shall not change the value allocated between resets" in NVMe 5.27.1.5 
doesn't apply to fabric controllers?

/John

> 	Fred
> 


