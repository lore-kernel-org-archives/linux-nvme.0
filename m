Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D7EC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 13:44:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4DFB2076E
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 13:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hv+lFD4f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O6zqLTau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DFB2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EP+0P3GHgD03qDyoDR3eaJzlsDLAbkXAMsxTZJhg5Y4=; b=hv+lFD4fVeq2WOrMwU9cdIS39
	PnjVwfULshdUp8bfGfI0WkkLWwWZ0QbEOoXFMJ5l5/jEbUESUHLmn7nv+F3yBrIyMv860KwE6R6G+
	vqcji1HserOiHdyNtS+19QZePxsEt3o/Pj1iIAsljnUEtXtT89qiwqv8nmsW2uDOCtsjKb9fkd+Y6
	/Sl1efyun8x/bewRTpgemJaPv7+JeBg49+1h5hJsj8XqrZwFt4Jwk6zbXOHsflRsT+T4aFlfXWRIg
	lXF+ffsVj40eJgFMdJNGySGk8Z9B+919vXCegTgp6O/Lo2N4VycdzF1OTfi0sk7B23oV8W+f71Kaj
	YbM9JHRQQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joSAd-0004o8-BL; Thu, 25 Jun 2020 13:44:03 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joSAb-0004nI-2o
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 13:44:01 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PDfw5v007702;
 Thu, 25 Jun 2020 13:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=kyJIS1Y+kUDLLL7qcfvaJLI8q0bnziVSNLW88hQZZBo=;
 b=O6zqLTauFu9wMTdBTYffBftFZU+TzTL7YgaRrk8n2ubg8Xyfnzj2mcGv7GHMlIh89Dj4
 i5rZEhzk35JXQjdCK/xw7XO9ETwf1PGGyBWyotkWWdhQhsTFujWZa4dnTH2QAbkwPY0d
 /P9FlF+SGC7I69lB2kdfAEnm5eloVVwqtKJmRw7pyHv9ixijcOZIq50BNWjODkFYv4Ub
 9DaRYKaxWTV7bTB/ke2JKG6fhT9+W5pCSSjpEmTLZYF5Q9wJ/36J6NYwFUS85TvI8QcQ
 hR1+vOXdMcTOPUZrN3u5hAH6WwwvIQTX4g4JPox88VVwwHTyBIv41Jd0/EixQhHw9ZFc nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 31uusu0m50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Jun 2020 13:43:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PDY0fK022694;
 Thu, 25 Jun 2020 13:41:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 31uur18usv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2020 13:41:52 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05PDfow4009408;
 Thu, 25 Jun 2020 13:41:51 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 25 Jun 2020 13:41:50 +0000
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: NVMe over Fabrics transport requirements support
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <d0fad47d-d67b-0d0f-5a75-cc73aa0c5ed0@grimberg.me>
Date: Thu, 25 Jun 2020 09:41:49 -0400
Message-Id: <C20E2DE8-AE82-427F-964E-29006CC4E4BF@oracle.com>
References: <eaceb06a-79d3-2b97-c975-6f2f641e90c7@yandex.ru>
 <71232e85-054b-638a-c168-4829e97f917f@grimberg.me>
 <39e303bc-7d99-5202-dcb7-4d2f487760bc@mellanox.com>
 <75010fdd-36dd-2ac0-a658-4fc7070744f1@grimberg.me>
 <3a774d39-f786-bdad-0dbc-1dd0e6a56a15@mellanox.com>
 <d0fad47d-d67b-0d0f-5a75-cc73aa0c5ed0@grimberg.me>
To: Sagi Grimberg <sagi@grimberg.me>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=18 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006250087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=18
 bulkscore=0
 cotscore=-2147483648 malwarescore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250088
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
Cc: Or Gerlitz <ogerlitz@mellanox.com>, Alex Talker <alextalker@yandex.ru>,
 Boris Pismenny <borisp@mellanox.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> On Jun 24, 2020, at 4:25 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
> 
> 
>>>> I have some early-stage patches the enable NVMe-TLS on the host's
>>>> receive side and on the target's transmit side. It requires
>>>> some TLS infra work, but the real problem is the userspaece side,
>>>> as the TLS handshake cannot be in the kernel. Consequently,
>>>> nvme-tcp must be modified to use sockets provided by userspace,
>>>> and I suspect that this may be controversial.
>>> Yes... That part is going to be annoying as hell. It's unnatural
>>> no matter how we tackle it...
>> Annoying, but I doubt that it is worth adding the TLS handshake to the kernel to overcome it.
> 
> I tend to agree, I've heard that Trond is looking to do something
> similar with NFS rpc.gssd but I wasn't able to get a hold of him to
> share where he is at.
> 
> CC'ing Chuck, whom I've briefly discussed this with some time ago.

I don't know of any recent progress.

The plan was to build something similar to gssd based on netlink as
the upcall mechanism (gssd uses RPC pipefs). Trond is aware of the
desire to treat TLS handshake as a generic mechanism rather than
one that is RPC-centric.


>>> Please do note that there is ongoing update technical proposal on the
>>> NVMe TWG to update the spec to match TLS v1.3 (not sure if you are a
>>> member or not).
>> Yes, I've seen some draft for this, although I'm not a member.
>> TLS1.3 is supported by KTLS in the same way as TLS1.2, e.g. the
>> handshake must go through a userspace application, and the data-path
>> is in the kernel.
>>>> At the moment,
>>>> I'm busy with other things, but I expect to post an RFC after
>>>> I finish with my current project.
>>> Great! Looking forward to seeing some patches for it!

--
Chuck Lever




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
