From: joseph.r.gruher@intel.com (Gruher, Joseph R)
Date: Thu, 27 Apr 2017 15:59:07 +0000
Subject: cqe dump errors on target while running nvme-of large block
 read IO
In-Reply-To: <209CAF47-1CE4-4A22-9E11-6377CEF62495@mellanox.com>
References: <DE927C68B458BE418D582EC97927A9285505C9EA@ORSMSX113.amr.corp.intel.com>
 <47f19583-1882-09d4-ce1c-534b8e59068b@mellanox.com>
 <DE927C68B458BE418D582EC97927A9285505F0C9@ORSMSX113.amr.corp.intel.com>
 <52c550c1-849b-7ea5-ab34-56543cb9069d@mellanox.com>
 <991b26ec-69d3-9e1c-ed3e-0d6e6618e73a@grimberg.me>
 <DE927C68B458BE418D582EC97927A92855072ECF@ORSMSX113.amr.corp.intel.com>,
 <8521776c-9557-04f1-9c7c-8389e083052b@grimberg.me>
 <209CAF47-1CE4-4A22-9E11-6377CEF62495@mellanox.com>
Message-ID: <DE927C68B458BE418D582EC97927A92855073FBB@ORSMSX113.amr.corp.intel.com>

> Starting in next release, for ConnectX-4 and above PFC isn't required as long as
> ECN is enabled.
> 
> With current release we also expect to get good results with ECN and no PFC.
> 
> Joseph - is ECN enabled on your system?

No, we haven't done anything to set up ECN, so I assume it is not enabled.
