From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 28 Aug 2017 23:15:57 +0300
Subject: [PATCH] nvmet: Add support for HOST_ID feature.
In-Reply-To: <A5F28D4A728A7E41839CDC5C3B5A01E8872735FF@FMSMSX103.amr.corp.intel.com>
References: <1503922057-1141-1-git-send-email-omri@excelero.com>
 <859a5a5d-9aa1-44e6-7d67-42fed0339a8b@grimberg.me>
 <A5F28D4A728A7E41839CDC5C3B5A01E8872735FF@FMSMSX103.amr.corp.intel.com>
Message-ID: <9f119f3b-cca9-7c6e-64ff-53bd24249de3@grimberg.me>


> The specification says that NVMe-oF must use a 128-bit host ID - from NVMe 1.3, 5.21.1.19.2:
> 
> "The Host Identifier is a mandatory feature in NVMe over Fabrics.  The Host Identifier shall be an extended 128-bit Host Identifier."
> 
> The target should also check the EXHID bit in the Get Features - Host Identifier command.

That's true, We should work with uuid_t for hostids. thanks Daniel.
