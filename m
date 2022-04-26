Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64701C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 14:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qimekw0r2tYujclLkII88oeZ1jrynUrA+JQHRNSIrm0=; b=41ZKrfU+IG0QUpon95wdQkJuHn
	mNpmjxsPpKmrlrgSG5wIFt5YJF5lbD2hNf2Qa6P259hIGZsAIh0a3jxHq4032EXTqZ1oh45r6Nbnu
	XXhAiii/EWGY0t+JPsQeyt3hCA5SfPraaO3pErjj+XP/oihtOpBFazyvvzotXx+V57ZHmIAcJppfT
	hzrifXYdAQMA/IzkRdNdDUkzyi2fgPAd1tKROgGyfagSLCU2hY51Uf6z4YY/n14GmqDYvqkC9+/U8
	oWzatcX+Muc4UhoXjLn540UGpxOHKHhDHPnPGV+u6mhSN8HMAoc3BX1RkOL4wM49tGCm6Ttj9NeJa
	1xY65RAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njMat-00F369-4T; Tue, 26 Apr 2022 14:55:11 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njMaq-00F34s-Md
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 14:55:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 682C2B82048;
 Tue, 26 Apr 2022 14:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6ECC385AA;
 Tue, 26 Apr 2022 14:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650984906;
 bh=mBBJfMdQEAD7EAvlp5VzkWfv+DhsEhFD059k90qHrY8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jJbrM3gMgGDpbLfXpV1GxS5xAGIKT9oFkVUo8elExDVKlC36ei9tGM8VO/S08FI/g
 IutRjZMnUIJUjhkd1Cq++lQIeb1o36Wh09gi8lzx3cjviH9bS1WLEwJ1lmX4wDNZB8
 lgZ/joo0wBg05ickLxda9QVf8w7EHAmpz1BeAYaFD38OThOjsiooYP1stXAAZ7g5/A
 r0j5TMS+StWVFVN7thO6oj2fJHT2639aJHJ0Xlu39lzsAWLZ3MQZD3F0pgxfyHB602
 MGogFrAx2zyevx4MzX79IVhGcoVX8OK0E/B6Kq5fbC1eFsxD7WiJJ98F4kQOAtNTVV
 PT6Gg37A6BYUQ==
Date: Tue, 26 Apr 2022 07:55:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: netdev <netdev@vger.kernel.org>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-cifs@vger.kernel.org"
 <linux-cifs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "ak@tempesta-tech.com"
 <ak@tempesta-tech.com>, "borisp@nvidia.com" <borisp@nvidia.com>,
 "simo@redhat.com" <simo@redhat.com>
Subject: Re: [PATCH RFC 4/5] net/tls: Add support for PF_TLSH (a TLS
 handshake listener)
Message-ID: <20220426075504.18be4ee2@kernel.org>
In-Reply-To: <E8809EC2-D49A-4171-8C88-D5E24FFA4079@oracle.com>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
 <20220425101459.15484d17@kernel.org>
 <E8809EC2-D49A-4171-8C88-D5E24FFA4079@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_075508_929570_EAC2056D 
X-CRM114-Status: GOOD (  13.26  )
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

On Tue, 26 Apr 2022 13:48:20 +0000 Chuck Lever III wrote:
> > Create the socket in user space, do all the handshakes you need there
> > and then pass it to the kernel.  This is how NBD + TLS works.  Scales
> > better and requires much less kernel code.  
> 
> The RPC-with-TLS standard allows unencrypted RPC traffic on the connection
> before sending ClientHello. I think we'd like to stick with creating the
> socket in the kernel, for this reason and for the reasons Hannes mentions
> in his reply.

Umpf, I presume that's reviewed by security people in IETF so I guess
it's done right this time (tm).

Your wording seems careful not to imply that you actually need that,
tho. Am I over-interpreting?

