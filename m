From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 26 Apr 2017 23:39:17 -0700
Subject: cqe dump errors on target while running nvme-of large block read
 IO
In-Reply-To: <209CAF47-1CE4-4A22-9E11-6377CEF62495@mellanox.com>
References: <DE927C68B458BE418D582EC97927A9285505C9EA@ORSMSX113.amr.corp.intel.com>
 <47f19583-1882-09d4-ce1c-534b8e59068b@mellanox.com>
 <DE927C68B458BE418D582EC97927A9285505F0C9@ORSMSX113.amr.corp.intel.com>
 <52c550c1-849b-7ea5-ab34-56543cb9069d@mellanox.com>
 <991b26ec-69d3-9e1c-ed3e-0d6e6618e73a@grimberg.me>
 <DE927C68B458BE418D582EC97927A92855072ECF@ORSMSX113.amr.corp.intel.com>
 <8521776c-9557-04f1-9c7c-8389e083052b@grimberg.me>
 <209CAF47-1CE4-4A22-9E11-6377CEF62495@mellanox.com>
Message-ID: <20170427063917.GA28074@infradead.org>

On Thu, Apr 27, 2017@04:29:27AM +0000, Majd Dibbiny wrote:
> Starting in next release, for ConnectX-4 and above PFC isn't required as long as ECN is enabled.

What does "release" mean in this context?  Firmware version?
