Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5321C47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 19:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=44qChRTPD61395LMtG48BDgNguyheKnNEp08f7VPJZs=; b=WBa4sfkTuaRK6WzeiO7+7B7Sj0
	UOmVtrrYhrEoE5d4KQ6qeqscAGZ1wuJ5Irhd5p0ldjtnHp6y4Eh+j9S9Bli0SCdBmYGC9qLpOwDrZ
	oHfcFkutOSkjMXZPaiLLWhU0Pr1kTp+ByCBdFwDoLlDOf+9vWAFRNuWILORmqwhjSwNbMhXQ/4HIG
	Bm1WWVr92CauyDgdgsfNFw7zFvy+4YUrtJwLHbGKNzVgVI7x6iHSGzbvnxYisNAtW9jgojZ883FtW
	+F4HfGmXyIBJWnjB4Vl/0/dz/B/Z9YxFGu3Wa0N74LSHrJfU6VGkA/AqfW/2UmOgZ+E2ZrZOUSda3
	rW1wivTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLTUj-00F61b-06;
	Thu, 04 Jan 2024 19:35:09 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLTUf-00F607-01
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 19:35:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=44qChRTPD61395LMtG48BDgNguyheKnNEp08f7VPJZs=; b=AUadH55wfbxjUdba5d/WSpd/Bp
	dbmY84gRWVECabuZgF3msNgfiId93t9Elj4617tqieMDMpfQ20Vg5243BShSBjiYZkcWhliY5cLjB
	woykAg3LKdsSJeZKbIPDNdgEUWOBZWydCyVMk/jF+Di5P+a9TPB9sfTcgAI9Msg6MrMaew8JWeNS/
	EtNOCBkmmv17A+w7jqPHCanplIKc8aUybUJ8TmhfQDqqm2my2+hiJBRyf/YXb+jixtfdSQxkNzXbB
	TEa7J0Tu25wRdOwCbjYGg52y5X9NMhgT7N/cvJVtKiQxFaTNDpimDB5XZd7hKtnu1VuAQFwCIflc0
	K7dXK+4NSc336TVSjvwH9vOn01mEyKWwGuxtBfQyLjxXfTFtUAcob80gU1+nTLMcyM6o4uYUpfWH3
	FBTjX5s5tkIWfDaEkuqZBDueVFGGA1Aqc2fFPkcbeRXOoQYK7e3EuV9G4Lhxlxt4yqHhT7SoaDiKV
	DZh5HFpP0usNrbMwePQpv4fd;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rLTUc-006U7S-1N;
	Thu, 04 Jan 2024 19:35:02 +0000
Date: Thu, 4 Jan 2024 11:34:58 -0800
From: Jeremy Allison <jra@samba.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org, jra@samba.org
Subject: Re: [PATCH 2/5] PCI: Support two-pass shutdown
Message-ID: <ZZcIYpmJsx7n5WGe@jeremy-HP-Z840-Workstation>
References: <20240103210405.3593499-3-jallison@ciq.com>
 <20240104185524.GA1823422@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240104185524.GA1823422@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_113505_041670_FE49895A 
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 04, 2024 at 12:55:24PM -0600, Bjorn Helgaas wrote:
>On Wed, Jan 03, 2024 at 01:04:02PM -0800, Jeremy Allison wrote:
>> From: Tanjore Suresh <tansuresh@google.com>
>>
>> Enhances the base PCI driver to add support for two-pass
>> shutdown. Adds shutdown_wait() method.
>>
>> Assume a device takes n secs to shutdown. If a machine has been
>> populated with M such devices, the total time spent in shutting down
>> all the devices will be M * n secs if the shutdown is done
>> synchronously. For example, if NVMe PCI Controllers take 5 secs
>> to shutdown and if there are 16 such NVMe controllers in a system,
>> system will spend a total of 80 secs to shutdown all
>> NVMe devices in that system.
>>
>> In order to speed up the shutdown time, a two-pass interface to
>> shutdown has been implemented. The caller calls the shutdown method
>> for each device in turn to allow a shutdown request to be sent,
>> then the caller walks the list of devices and calls shutdown_wait()
>> to synchronously wait for the shutdown to complete.
>>
>> In the NVMe case above, all 16 devices will process the shutdown
>> in parallel taking the total time to shutdown down to the time
>> for one NVMe PCI Controller to shut down.
>>
>> This will significantly reduce the machine reboot time.
>>
>> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
>> Signed-off-by: Jeremy Allison <jallison@ciq.com>
>
>Rewrap commit log to fill 75 columns.  Use present tense imperative,
>e.g., "Enhance ..." and "Add ..."
>
>Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Done for next rev. Thanks !

