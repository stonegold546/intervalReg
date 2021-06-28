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
}
