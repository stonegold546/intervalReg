import QtQuick		2.12
import JASP.Module	1.0

Description
{
	name		: "intervalReg"
	title		: qsTr("Interval regression")
	description	: qsTr("This module permits interval-censored regression.")
	icon		: "analysis-classical-regression.svg"
	version		: "0.1"
	author		: "James Uanhoro"
	maintainer	: "James Uanhoro <James.Uanhoro@unt.edu>"
	website		: "https://jamesuanhoro.com"
	license		: "GPL (>= 3)"

	GroupTitle
	{
		title: qsTr("Continuous")
	}
	Analysis
	{
		menu:	qsTr("Unbounded (normal)")
		title: qsTr("Interval reg - normal")
		func:	"do_normal"
	}
	Analysis
	{
		menu:	qsTr("Bounded (beta)")
		title: qsTr("Interval reg - beta")
		func:	"do_beta"
	}
	Separator{}
	GroupTitle
	{
		title: qsTr("Discrete")
	}
	Analysis
	{
		menu:	qsTr("Bounded (binomial / beta-binomial)")
		title: qsTr("Interval reg - (beta-)binomial")
		func:	"do_bd"
	}
}
