Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7492C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 17:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sHDRRByrp+K0S9sa7Dj6/eenmtzIvCMXpaIu1gLNCgs=; b=CmtI6h1qw8USLZOIY9EE3ZJ6JE
	hcmxbxlZExaJD0qiHMl1VmMFVdgJUC/2Mp5r5hi2rWM4WpxL2WX/k04NzJ3/QweYlUZl5ZcBIIefn
	hBYyLDPqAFySKspF7OgFDG1YcuIue97IWmgP5BosjXSQdFgr1HkZD7HnI0l7I8N+78byx/O2bhooF
	Yt5Ck9vkynG7j56NPnebOPmvVPItcOKV50sgk0rHi2TjgOSJXmVf6rtDjiZdGeg0I2Op8EqrriFf4
	oSUPMdmg2j5ahuYbNHUG2rAdQpOETT0On5VEhtIS4Jz3HVg6fP//FZ/bahMswu/JgYN4CfK43BP9y
	UfP7dwMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbQAm-00FvH0-QE; Mon, 04 Apr 2022 17:07:24 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbQ6X-00Ft8y-Qm
 for linux-nvme@lists.infradead.org; Mon, 04 Apr 2022 17:03:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A9FCEB8171B;
 Mon,  4 Apr 2022 17:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16C0C2BBE4;
 Mon,  4 Apr 2022 17:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649091778;
 bh=bxjobPk05q5cQGxdLA5lkMMCa3tFIu5/01svipg2CY4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SJeNPqWLu7utEIhZLAKKGIXibN83JeIpOTJd1W5FFKcKaG+PX6rUxleBR+MWHRYsP
 2nS1mZgZjCw/84KBP2Vtq4kFoYZjHx1BZRlv1H/NPpBXL6w4BNzLf2j09mR8N2xQIg
 MLHOniUCI4m2pEYTc6bMyMkmK3W1s1xMgFS0w8wg47JhvjmMsjimaGpPfcZNNxHfbj
 GLloDz+gboZvXw1ctoLqivOFHn1Hd4SKlwNL1rODnWEtcrycku95Th6yKPT3y9DAU+
 lu6Iao4MLQWLkjE6CtiqCnPhf+Jegl6+p110y7OUY5GpxXaUa72fhqRPEYseJSeX3d
 awV0DM2/h4Dkw==
Date: Mon, 4 Apr 2022 11:02:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Yi Zhang <yi.zhang@redhat.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Message-ID: <Ykskv/gp2s6PWiHp@kbusch-mbp.dhcp.thefacebook.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <4A24C337-5EF9-4C3A-A112-BA75934AC78B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4A24C337-5EF9-4C3A-A112-BA75934AC78B@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_100302_083019_AC3E5460 
X-CRM114-Status: GOOD (  18.79  )
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

On Mon, Apr 04, 2022 at 04:39:06PM +0000, Alan Adamson wrote:
> 
> [   97.083215] nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
> 
> An error from the device (status=2/Invalid Field) when an Identify (0x6) command was issued. Prior to the patch,
> the nvme driver didn’t display the error.
 
And it's harmless. The driver is querying an optional identification and it's
okay if the device doesn't support it, but the driver doesn't know if the
device supports until it tries it.
 
> > On Apr 3, 2022, at 7:28 AM, Yi Zhang <yi.zhang@redhat.com> wrote:
> > 
> > Hello
> > 
> > I found this error log during blktests[1] with the latest
> > linux-block/for-next, seems it was introduced after commit[2], is that
> > expected?
> > 
> > [1]
> > [   96.931911] run blktests nvme/004 at 2022-04-02 20:53:16
> > [   97.024693] loop: module loaded
> > [   97.029319] loop0: detected capacity change from 0 to 2097152
> > [   97.039641] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [   97.068847] nvmet: creating nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
> > [   97.083215] nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
> > [   97.090108] nvme nvme0: creating 32 I/O queues.
> > [   97.098283] nvme nvme0: new ctrl: "blktests-subsystem-1"
> > [   98.136900] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> > 
> > [2]
> > commit bd83fe6f2cd2133beaac7c423fd36c3515048fc8
> > Author: Alan Adamson <alan.adamson@oracle.com>
> > Date:   Thu Feb 3 00:11:53 2022 -0800
> > 
> >    nvme: add verbose error logging
> > 
> > -- 
> > Best Regards,
> >  Yi Zhang
> > 
> 

