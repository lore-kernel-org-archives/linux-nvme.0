From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 25 Apr 2017 10:58:40 -0600
Subject: [RFC 1/8] Introduce Peer-to-Peer memory (p2pmem) device
In-Reply-To: <117239810.400362790.1493121533234.JavaMail.zimbra@kalray.eu>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <c8edc480-a2ac-a763-8438-18f3396db483@deltatee.com>
 <e2165253dc355d5cb223e754d78047b1@codeaurora.org>
 <c5d7da85-41fd-2769-fcf8-b3c2a1fab95f@deltatee.com>
 <f0448277-9381-5c3d-d194-1efa1d1b44a6@codeaurora.org>
 <63d73995-4dfa-6270-ca13-972e0628011b@deltatee.com>
 <bed80d4e-7709-5991-498e-0ac361ca96a6@codeaurora.org>
 <ef507444-d3e5-0454-86a0-b5c4ae4b4dd9@deltatee.com>
 <117239810.400362790.1493121533234.JavaMail.zimbra@kalray.eu>
Message-ID: <190d9a89-e227-e410-5886-ee2e20a9b941@deltatee.com>



On 25/04/17 05:58 AM, Marta Rybczynska wrote:
> I would add one issue that doesn't seem to be addressed: in my experience
> P2P doesn't work when IOMMU activated. It works best with deactivation at
> the BIOS level, even the kernel options are not enough in some cases.

Well this would likely be addressed by 'arch_p2p_cross_segment' as
proposed by Jason.

Logan
