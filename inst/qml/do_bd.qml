import QtQuick 2.8
import QtQuick.Layouts 1.3
import JASP.Controls 1.0

Form
{
    columns: 2
    VariablesForm
    {
        AvailableVariablesList { name: "allVariablesList" }
        AssignedVariablesList { name: "lower"; title: qsTr("Lower bound"); singleVariable: true; allowedColumns: ["scale"] }
        AssignedVariablesList { name: "upper"; title: qsTr("Upper bound"); singleVariable: true; allowedColumns: ["scale"] }
        CheckBox { name: "interceptOnly"; label: "Intercept-only?" }
        AssignedVariablesList { name: "predictors"; title: qsTr("Predictors") }
    }

    Group
    {
        title: qsTr("Data limits (e.g. upper limit would be 15 for a test with 15 questions)")
        IntegerField { name: "max"; label: qsTr("true upper bound");  }
    }
}
