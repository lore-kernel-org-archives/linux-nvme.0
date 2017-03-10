From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Fri, 10 Mar 2017 19:37:58 +0000
Subject: [LFS/MM TOPIC][LFS/MM ATTEND]: - Storage Stack and Driver
 Testing methodology.
In-Reply-To: <CO2PR04MB2184DB653C04FB620B41435486670@CO2PR04MB2184.namprd04.prod.outlook.com>
References: <CO2PR04MB218427BF42159B20FB26F74186670@CO2PR04MB2184.namprd04.prod.outlook.com>
 <CO2PR04MB2184DB653C04FB620B41435486670@CO2PR04MB2184.namprd04.prod.outlook.com>
Message-ID: <1489174661.2548.5.camel@sandisk.com>

On Tue, 2017-01-10@22:40 +0000, Chaitanya Kulkarni wrote:
> Participants:-
> ------------------
> I'd like to invite developers from different subsystems to discuss an approach towards?
> a unified testing methodology for storage stack and device drivers belongs to?
> different subsystems.
> 
> Topics for Discussion:-
> ------------------------------
> As a part of discussion following are some of the key points which we can focus on:-
> 1. What are the common components of the kernel used by the various subsystems?
> 2. What are the potential target drivers which can benefit from this approach??
> ? (e.g. NVMe, NVMe Over Fabric, Open Channel Solid State Drives etc.)
> 3. What are the desired features that can be implemented in this Framework?
> ? (code coverage, unit tests, stress testings, regression, generating Coccinelle reports etc.)?
> 4. Desirable Report generation mechanism?
> 5. Basic performance validation?
> 6. Whether QEMU can be used to emulate some of the H/W functionality to create a test?
> ? platform? (Optional subsystem specific)

Regarding existing test software: the SRP test software is a thorough test of
the Linux block layer, SCSI core, dm-mpath driver, dm core, SRP initiator and
target drivers and also of the asynchronous I/O subsystem. This test suite
includes experimental support for the NVMeOF drivers. This test suite supports
the rdma_rxe driver which means that an Ethernet adapter is sufficient to run
these tests.

Note: the focus of this test suite is the regular I/O path and device removal.
This test suite neither replaces the libiscsi tests nor xfstests.

See also https://github.com/bvanassche/srp-test.

Bart.
