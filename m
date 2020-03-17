Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78FAC10F29
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 12:30:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F56220767
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 12:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bS4n9f2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F56220767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rf1Ckiu738/TR975m9WJcFAymJWYDX4V1MRXY+UkJus=; b=bS4n9f2IXtvjfeue8G/yXYQLQ
	AV/OrALgtwRyJCLZzltoqRSSS4DHZ3JalsuYgPl0qWMHwNNqLKVsvfY+7B5h1UY8JbgbUo/PVa/VU
	2alASb+gD0DWJCYrDM1xtm92lw+Uz7JOOoOlJDx04GIN36xLXE++iRSCiteXfRiYZZNZQsJ6XCQ6F
	CvrOu5P/7tc4h+SdRiCMfwWpWIMtaBK2ZRdkcn6BLQaOdhaVd6pUsYm+ZHss/xHiLs3XwE1wyVnp3
	THYcrEY9gxhdWcA+SucBWcgbxbSh83Ii73KK77PnVuFk7rlj8iHp0AWX12MrheYlxDicpFOCfFWJY
	riNMnge9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEBMb-00072b-TN; Tue, 17 Mar 2020 12:30:29 +0000
Received: from p3plsmtpa07-02.prod.phx3.secureserver.net ([173.201.192.231])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEBJB-0002E9-IR
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 12:26:59 +0000
Received: from [192.168.0.78] ([24.218.182.144]) by :SMTPAUTH: with ESMTPSA
 id EBJ6juAsqbVbmEBJ6jPaqY; Tue, 17 Mar 2020 05:26:53 -0700
X-CMAE-Analysis: v=2.3 cv=Z5yS40ZA c=1 sm=1 tr=0
 a=ugQcCzLIhEHbLaAUV45L0A==:117 a=ugQcCzLIhEHbLaAUV45L0A==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=AGRr4plBAAAA:8
 a=VnNF1IyMAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=pQTwyGJYnAKZfrNpIvMA:9
 a=QEXdDO2ut3YA:10 a=bOnWt3ThIoLzEnqt84vq:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
To: Bernard Metzler <BMT@zurich.ibm.com>,
 Krishnamraju Eraparaju <krishna2@chelsio.com>
References: <20200316162008.GA7001@chelsio.com>
 <OF1E443249.92333F66-ON0025852E.002FF389-0025852E.00345020@notes.na.collabserv.com>
From: Tom Talpey <tom@talpey.com>
Message-ID: <f6a79f64-a394-e1da-7565-bcb2d544bc58@talpey.com>
Date: Tue, 17 Mar 2020 08:26:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <OF1E443249.92333F66-ON0025852E.002FF389-0025852E.00345020@notes.na.collabserv.com>
Content-Language: en-US
X-CMAE-Envelope: MS4wfM3yiwoHHy2gP6OanuHhz9lIGhRbFdYC7DSPmwr8e02LpNp2CWHI+gmFCTXNHaYD5MBz8A+FtEttbRAjbITT8l31AEVbx4ddSC3HROBSBSWGryFCEv8O
 Wzcy+kgz91gWym6HHAtG1Re884pfrgqVUMLkVAEPa00C4UECsTI6CchzkMaoxph+gALU+sZEwRHmy1zSlnq7CZfSGFDM67n4kGnkFVO7Zeg0GvD+T2RGWrVj
 uYOLABdDkxSXT5dpSHV7d6roMAduHtuX5f7+Jsvdt4Bg2NzC9XKPha5YmUENnSodlpshQRsSSSDxGgFHSj/YHZpp/tigz1rrIIqewEr7t6jkiGEtAhrgUriV
 XCE81hUCCG+vF84YB47xUESgjgq6oiIx03C2YRNZ+1OrJWOY2WA=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_052657_635251_3AF0EF63 
X-CRM114-Status: GOOD (  18.46  )
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
Cc: sagi@grimberg.me, linux-rdma@vger.kernel.org,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Nirranjan Kirubaharan <nirranjan@chelsio.com>, linux-nvme@lists.infradead.org,
 hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/17/2020 5:31 AM, Bernard Metzler wrote:
> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
> 
>> To: "Bernard Metzler" <BMT@zurich.ibm.com>, sagi@grimberg.me,
>> hch@lst.de
>> From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>> Date: 03/16/2020 05:20PM
>> Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
>> "Nirranjan Kirubaharan" <nirranjan@chelsio.com>, "Potnuri Bharat
>> Teja" <bharat@chelsio.com>
>> Subject: [EXTERNAL] broken CRCs at NVMeF target with SIW & NVMe/TCP
>> transports
>>
>> I'm seeing broken CRCs at NVMeF target while running the below
>> program
>> at host. Here RDMA transport is SoftiWARP, but I'm also seeing the
>> same issue with NVMe/TCP aswell.
>>
>> It appears to me that the same buffer is being rewritten by the
>> application/ULP before getting the completion for the previous
>> requests.
>> getting the completion for the previous requests. HW based
>> HW based trasports(like iw_cxgb4) are not showing this issue because
>> they copy/DMA and then compute the CRC on copied buffer.
>>
> 
> Thanks Krishna!
> 
> Yes, I see those errors as well. For TCP/NVMeF, I see it if
> the data digest is enabled, which is functional similar to
> have CRC enabled for iWarp. This appears to be your suggested
> '-G' command line switch during TCP connect.
> 
> For SoftiWarp at host side and iWarp hardware at target side,
> CRC gets enabled. Then I see that problem at host side for
> SEND type work requests: A page of data referenced by the
> SEND gets sometimes modified by the ULP after CRC computation
> and before the data gets handed over (copied) to TCP via
> kernel_sendmsg(), and far before the ULP reaps a work
> completion for that SEND. So the ULP sometimes touches the
> buffer after passing ownership to the provider, and before
> getting it back by a matching work completion.

Well, that's a plain ULP bug. It's the very definition of a
send queue work request completion that the buffer has been
accepted by the LLP. Would the ULP read a receive buffer before
getting a completion? Same thing. Would the ULP complain if
its application consumer wrote data into async i/o O_DIRECT
buffers, or while it computed a krb5i hash? Yep.

> With siw and CRC switched off, this issue goes undetected,
> since TCP copies the buffer at some point in time, and
> only computes its TCP/IP checksum on a stable copy, or
> typically even offloaded.

An excellent test, and I'd love to know what ULPs/apps you
caught with it.

Tom.

> Another question is if it is possible that we are finally
> placing stale data, or if closing the file recovers the
> error by re-sending affected data. With my experiments,
> until now I never detected broken file content after
> file close.
> 
> 
> Thanks,
> Bernard.
> 
> 
> 
>> Please share your thoughts/comments/suggestions on this.
>>
>> Commands used:
>> --------------
>> #nvme connect -t tcp -G -a 102.1.1.6 -s 4420 -n nvme-ram0  ==> for
>> NVMe/TCP
>> #nvme connect -t rdma -a 102.1.1.6 -s 4420 -n nvme-ram0 ==> for
>> SoftiWARP
>> #mkfs.ext3 -F /dev/nvme0n1 (issue occuring frequency is more with
>> ext3
>> than ext4)
>> #mount /dev/nvme0n1 /mnt
>> #Then run the below program:
>> #include <stdlib.h>
>> #include <stdio.h>
>> #include <string.h>
>> #include <unistd.h>
>>
>> int main() {
>> 	int i;
>> 	char* line1 = "123";
>> 	FILE* fp;
>> 	while(1) {
>> 		fp = fopen("/mnt/tmp.txt", "w");
>> 		setvbuf(fp, NULL, _IONBF, 0);
>> 		for (i=0; i<100000; i++)
>> 		     if ((fwrite(line1, 1, strlen(line1), fp) !=
>> strlen(line1)))
>> 			exit(1);
>>
>> 		if (fclose(fp) != 0)
>> 			exit(1);
>> 	}
>> return 0;
>> }
>>
>> DMESG at NVMe/TCP Target:
>> [  +5.119267] nvmet_tcp: queue 2: cmd 83 pdu (6) data digest error:
>> recv
>> 0xb1acaf93 expected 0xcd0b877d
>> [  +0.000017] nvmet: ctrl 1 fatal error occurred!
>>
>>
>> Thanks,
>> Krishna.
>>
>>
> 
> 
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
