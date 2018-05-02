From: CW-Joel.Dedrick@taec.toshiba.com (CW-Joel Dedrick)
Date: Wed, 2 May 2018 22:23:56 +0000
Subject: Redundant connections vs. state-free initiator provisioning
Message-ID: <F59A32945E11144584BEC2C480B2819A974202B4@EXMAIL1.taec.toshiba.com>

Could someone explain the use-case for establishing multiple connections between the same Host and Subsystem (via the same port.)?

This behavior conflicts with what would otherwise be a very clean & centralized way to provision large numbers of initiators, (which could all be identically configured but provisioned differently).  This could be done by implementing a discovery controller/target that selectively exposes only the resources for which each initiator has permissions.  Each initiator could just issue "connect all" and would get the appropriate logical block devices.

But, if multiple "connect all" commands result in multiple, redundant sets of block devices (as now), this would be too fragile to use.  I also understand from past threads on this topic that this behavior is different from FC, FWIW.

Thanks,
JHD
