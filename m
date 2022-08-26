Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410C6ECAAD6
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 19:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VTzlMgxLuhXSM5CJoS/uXvzBm2HcHawOapwpFFeIqfQ=; b=3L66RYtR8ObBt7ecZYI+F755MW
	oWDGzmT2kUETLtMDM/FlO6/6anGNQY2J2ItpqH4roCQzBxNYBmPmFciD/tvFmelOJZVFlJlNoKRBd
	3PxnFVxEIsjXfBNLhWzpS8bW3+B4FqLYCRl0Ye0bIFS1b+WJ3Ox6KDK2k3/mGjXrN3Iq1kRiEfpKq
	XCuHfnp9SSbV2fa2ORqnulQCUcoKMH8Z+t0fIAjghQpguG6Kn/CU8VLyhX5SPUzLjjV6SEpe/3EMH
	9QgcsPBZk9ZZ7DQOCI7b5yzaLzWWjCXK3oxdyw1luMBrzbn9r0E5xWMNIxmrl9bXiIaah8TsRrPh0
	VHi2Gs6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRfH9-00AtUA-08; Fri, 26 Aug 2022 19:45:55 +0000
Received: from out0.migadu.com ([94.23.1.103])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRfB6-00AnrT-RE
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 19:39:43 +0000
Message-ID: <6a50bd55-e8be-283d-1e57-731958bd1820@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1661542774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTzlMgxLuhXSM5CJoS/uXvzBm2HcHawOapwpFFeIqfQ=;
	b=NEdTHFf4uAS2cZKPcC33RnKLBD2ydG4AVriUadQtQvHxX9NDBezrBewQctwOrF0NxVqw7Y
	eZW6xmZsvBPfTNuhYhoI9lrBd1NFAw5iYEw1OFVN0RaZq0e6SiF+H7tkElyGge5LGUagpK
	bJ4yJPm/BCug1duCbdaRZJ62GjokRwo=
Date: Fri, 26 Aug 2022 13:39:31 -0600
MIME-Version: 1.0
Subject: Re: NVMe write protection support
Content-Language: en-US
To: Gilles Buloz <Gilles.Buloz@kontron.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <DU0PR10MB62528F66099C2311E2AF1EEE809A9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <YugctzU0uDZvfAal@infradead.org>
 <DU0PR10MB62528A77489B4ADE66503166809D9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <Yu4nt1bzSynhmeUF@infradead.org>
 <DU0PR10MB6252E237D18FCFB37CB17B8F80729@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <DU0PR10MB6252E237D18FCFB37CB17B8F80729@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_123941_607247_CCEC7C3A 
X-CRM114-Status: GOOD (  21.08  )
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



On 8/25/2022 2:26 AM, Gilles Buloz wrote:
>> On Sat, Aug 06, 2022 at 10:35:00 AM +0100, Christoph Hellwig wrote:
>>   
>>> On Tue, Aug 02, 2022 at 09:20:02AM +0000, Gilles Buloz wrote:
>>> Sorry Christoph, I'm completely newbie in NVMe and don't know what "Namespace Write Protection Config" means.
>>
>> Take a look at
>> https://nvmexpress.org/wp-content/uploads/NVM-Express-Base-Specification-2.0b-2021.12.18-Ratified.pdf
>> and search for this term.
> 
> Thank you for the specs.
> 
>>> What I mean is that all the NVMe content seen by the user is write protected.
>>
>> And that is what this feature is abut.
>>
>>> Our NVMe manufacturer partner has dedicated a pin of the module for global write protection.
>>
>> There is no concept of a 'module' in NVMe.
> 
> In fact this is a M.2 module : a M.2 PCIe SSD one. A M.2 GND pin has been reused for WP with a pull-up on module, so that if the module is plugged into a standard M.2 socket this pin is connected to GND and the module is not protected. And in a socket providing WP on this pin, the write protection can be enabled by setting the pin high or unconnected.
> 
In other words, your firmware needs to set bit 0 in the ID-NS's NSATTR 
field [1] in the Identify Namespace data structure(s) when WP pin is 
grounded.


>>> But if we enable this protection and attempt a write (we should not), we get a "critical medium error" which seems a bit brutal for a disk that is still valid but just write protected. So I would like to make sure the NVMe manufacturer has used the right method/status to report this write protection, and if possible get a less fatal error feedback.
>>
>> It seems like your manufacturer needs to read the NVMe spec and implement the correct features.
> 
> Yes, that's why I requested some tips from experts like you to be sure.
> And with the features implemented correctly, is a the case of a write to a protected module already handled/expected by the kernel ? and what message the kernel is expected to report in dmesg ?
Search for 'Write Protected'/'Write Protection' in [1] spec.
You will need to support certain command Status Codes in the controller 
to convey state information on commands that may change the namespace.

[1] NVM Express Base Spec 2.0b, Figure 280
https://nvmexpress.org/wp-content/uploads/NVM-Express-Base-Specification-2.0b-2021.12.18-Ratified.pdf

