Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB5BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u31F2HNYCPvJ5mJ3vrrRukQxIoMuMbwWK79E5on94IU=; b=CCBmnPAqtar7blbWWtIkPat1hn
	hdTJdHz87DE1ThidfsAro6+Gk92Z+JA4KV+X1UhhLBBK56aQJCtWuFY9+f8hdDsDmiuXTSXIcWXoA
	oYRM2tKKBWAJAWRsVx8z7cvvXjtgxortmrqUWlk/d681GxAYUwuw2Ek5spTTEib9kK3u4zxOg+ihG
	Bw25dNLfjuGCSIQz3QW1QV+DhiFTk5JCbQRtHye8p3sDvuY60Ch0FL4lS4Dl5iWjD199oro/tnXfC
	3OUy/fubVdotIlosZc9NpTaNA9hHQKjiiU5TIZj0NJadoTjzcRlbnO0YvFAXMmnfSq+Iag7HwRm12
	iyYNHb7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX4dp-00EP6a-4X; Wed, 23 Mar 2022 17:19:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX4dm-00EP3l-6Y
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 17:19:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648055959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u31F2HNYCPvJ5mJ3vrrRukQxIoMuMbwWK79E5on94IU=;
 b=F3hMXSBJE88BmrthLhhWiH56AZPfeaRbH2WNk2WJ/qFi+VKYWj0CnxdsENthA9zdPMaakT
 ltomLNw9AUtLcfVEDOi+jRV7nDHuK+5V0H9WM+9iQ+dRrb59YVbKt9PLNn4IFYTPsWvgZ5
 BpiBt7JJ8hWJQ+T+Ybi2vaAc4qey3kY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-KPqbC9vMPx-WidigSkGArA-1; Wed, 23 Mar 2022 13:17:34 -0400
X-MC-Unique: KPqbC9vMPx-WidigSkGArA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E3BE3C18527;
 Wed, 23 Mar 2022 17:17:33 +0000 (UTC)
Received: from [10.22.19.101] (unknown [10.22.19.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F02277ADA;
 Wed, 23 Mar 2022 17:17:32 +0000 (UTC)
Message-ID: <089e3056-e603-bd9e-6680-52a26cafa72e@redhat.com>
Date: Wed, 23 Mar 2022 13:17:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org,
 "Knight, Frederick" <frederick.knight@netapp.com>,
 Chris Leech <cleech@redhat.com>
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
 <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
 <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de> <20220315094950.GA5322@lst.de>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20220315094950.GA5322@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_101922_359970_7F687BEB 
X-CRM114-Status: GOOD (  31.05  )
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

Sorry I'm late to the party.  Please see my comments below.

On 3/15/22 05:49, Christoph Hellwig wrote:
> On Tue, Mar 15, 2022 at 10:06:26AM +0100, Hannes Reinecke wrote:
>> The core question really is: do we _want_ to expose the discovery subsystem
>> in configfs?
> 
> Well, if you want a freely configurable one we kinda have to, right?
> 
>> Unfortunately, exposing the discovery subsystem and trying to configure it
>> with configfs does _not_ match with the way discovery is implemented today.
>> While we currently only have a single discovery subsystem, it will only
>> ever return the subsystems visible from this particular port.

I don't see why this would need to change. What is it that you want to configure
in the new unique discovery subsystem(s) that would be any different from the
existing well known discovery subsystem?

> Well.  The original Fabrics spec had this concept of that magic discovery
> NQN, which implies that there is one subsystem (or many pretending to be
> one).  And that is what the implementation followed.  The varipus 80?? TPs
> then made a complete mess off that.

I agree that FMDS has made an overly complicated mess of NVMe-oF Discovery
with the new Discovery TPs. However, I am hoping that TP-8013 and TP-8014
could be used to help with some of the problem.

>> Hence this rather simple approach, having the 'normal' discovery subsystem
>> exposed, and let the admin configure it accordingly.
>>
>> I can look at keeping the internal implementation, and only expose unique
>> discovery controller (ie those with a unique subsystem NQN).
>> That would remove the need to having the 'discovery_nqn' attribute, and
>> address Christophs concerns.
> 
> I suspect if we want to support all the new mess from the FMDS group
> (and maybe we need to question the why a little more), then we should
> so something like:
> 
>   (1) keep the existing global NQN-based discovery as-is.

I agree that we need some way to support legacy hosts and legacy controllers
in the same fabric. What ever we do with TP-8010, etc., we need to be sure that
all hosts and all discovery controllers interoperate cleanly.

>   (2) maybe add a per-port known to allow disabling it if people really care
>   (3) allow creating additional discovery subsystems with non-default
>       NQNs that do not automatically get anything added to them and will
>       just be configured as needed through configfs
> 
> But maybe first we should take a step back and figure out what supporting
> TPAR8013 even buys us?

TP-8013 was designed to work with TP-8014. In fact, at one point we talked about
combining these two TPs into a single TP. The idea behind TP-8013 & 8014 was:

  1. All hosts will connect to the existing Discovery Service with the Well Known
     Discovery NQN and retrieve the Discovery Log pages for the HostNQN provided
     in the Fabric Connect command, as it is done today.

     It was assumed that Authenticating with the Well Known Discovery NQN would
     would not be needed or supported because:
     a) The Discovery Controller controls the Authenticate work flow and
        returning AUTHREQ=1 in the connect response would break legacy hosts.
     b) It doesn't make sense to have a Well Known Discovery NQN as a part of a psk.

  2. Discovery Controllers which support Authentication can return Discovery
     Log Page Entries with Subsystem Type (SUBTYPE): 03h - as defined by TP-8014.
     These DLPEs will contain Unique Discovery NQNs - as defined by TP-8013

  3. Hosts that support Authentication can then disconnect from the Well Known
     Discovery Controller and re-connect with the Unique Discovery NQN. These
     hosts should expect an AUTHREQ=1 response.

  4. Hosts that don't want to support Authentication can ignore the SUBTYPE 03h
     Log Page Entries and operate normally. This would include legacy hosts.

Hopefully, with some kind of a design like this, both legacy (non-authenticating)
and new (authenticating) hosts and discovery controllers can interoperate.

/John


